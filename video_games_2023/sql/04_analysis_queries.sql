/* =====================================================================
   04_analysis_queries.sql
   Business questions answered with SQL. Run each query on its own.
   ===================================================================== */

USE VideoGames2023;
GO

/* Q1. How many games released each month? */
SELECT MONTH(release_date)            AS month_number,
       DATENAME(MONTH, release_date)  AS month_name,
       COUNT(*)                       AS games_released
FROM games
GROUP BY MONTH(release_date), DATENAME(MONTH, release_date)
ORDER BY month_number;


/* Q2. Running total of releases through the year */
WITH monthly AS (
    SELECT MONTH(release_date) AS month_number, COUNT(*) AS games_released
    FROM games
    GROUP BY MONTH(release_date)
)
SELECT month_number,
       games_released,
       SUM(games_released) OVER (ORDER BY month_number) AS cumulative_releases
FROM monthly
ORDER BY month_number;


/* Q3. Which platforms got the most games, and what share of all 2023 games? */
SELECT pl.platform_name,
       pl.platform_family,
       COUNT(*) AS games,
       CAST(100.0 * COUNT(*) / (SELECT COUNT(*) FROM games) AS DECIMAL(5,1)) AS pct_of_all_games
FROM game_platforms AS gp
JOIN platforms AS pl ON pl.platform_id = gp.platform_id
GROUP BY pl.platform_name, pl.platform_family
ORDER BY games DESC;


/* Q4. Single-platform exclusives vs multi-platform releases */
WITH platform_counts AS (
    SELECT game_id, COUNT(*) AS platform_count
    FROM game_platforms
    GROUP BY game_id
)
SELECT CASE WHEN platform_count = 1 THEN 'Single platform'
            WHEN platform_count BETWEEN 2 AND 3 THEN '2-3 platforms'
            ELSE '4+ platforms' END AS release_strategy,
       COUNT(*) AS games
FROM platform_counts
GROUP BY CASE WHEN platform_count = 1 THEN 'Single platform'
              WHEN platform_count BETWEEN 2 AND 3 THEN '2-3 platforms'
              ELSE '4+ platforms' END
ORDER BY games DESC;


/* Q5. List every single-platform exclusive and where it launched */
SELECT g.title, pl.platform_name, pub.publisher_name
FROM games AS g
JOIN game_platforms AS gp ON gp.game_id = g.game_id
JOIN platforms AS pl      ON pl.platform_id = gp.platform_id
JOIN publishers AS pub    ON pub.publisher_id = g.publisher_id
WHERE g.game_id IN (SELECT game_id FROM game_platforms
                    GROUP BY game_id HAVING COUNT(*) = 1)
ORDER BY pl.platform_name, g.title;


/* Q6. Which games released on all three console families (PlayStation, Xbox AND Nintendo)? */
SELECT g.title, g.release_date
FROM games AS g
JOIN game_platforms AS gp ON gp.game_id = g.game_id
JOIN platforms AS pl      ON pl.platform_id = gp.platform_id
WHERE pl.platform_family IN ('PlayStation', 'Xbox', 'Nintendo')
GROUP BY g.title, g.release_date
HAVING COUNT(DISTINCT pl.platform_family) = 3
ORDER BY g.release_date;


/* Q7. Rank publishers by number of games released */
SELECT pub.publisher_name,
       COUNT(*) AS games,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS publisher_rank
FROM games AS g
JOIN publishers AS pub ON pub.publisher_id = g.publisher_id
GROUP BY pub.publisher_name
ORDER BY publisher_rank, pub.publisher_name;


/* Q8. Which games were self-published (developer and publisher are the same company)? */
SELECT g.title, d.developer_name AS studio
FROM games AS g
JOIN developers AS d   ON d.developer_id = g.developer_id
JOIN publishers AS pub ON pub.publisher_id = g.publisher_id
WHERE d.developer_name = pub.publisher_name
ORDER BY g.title;


/* Q9. Most common genres, and how widely each genre was released */
WITH platform_counts AS (
    SELECT game_id, COUNT(*) AS platform_count
    FROM game_platforms
    GROUP BY game_id
)
SELECT ge.genre_name,
       COUNT(*) AS games,
       CAST(AVG(1.0 * pc.platform_count) AS DECIMAL(3,1)) AS avg_platforms_per_game
FROM games AS g
JOIN genres AS ge          ON ge.genre_id = g.genre_id
JOIN platform_counts AS pc ON pc.game_id = g.game_id
GROUP BY ge.genre_name
ORDER BY games DESC, ge.genre_name;


/* Q10. Busiest release month for each platform family (ties are all shown) */
WITH family_months AS (
    SELECT pl.platform_family,
           DATENAME(MONTH, g.release_date) AS month_name,
           MONTH(g.release_date)           AS month_number,
           COUNT(DISTINCT g.game_id)       AS games
    FROM games AS g
    JOIN game_platforms AS gp ON gp.game_id = g.game_id
    JOIN platforms AS pl      ON pl.platform_id = gp.platform_id
    GROUP BY pl.platform_family, DATENAME(MONTH, g.release_date), MONTH(g.release_date)
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY platform_family ORDER BY games DESC) AS rn
    FROM family_months
)
SELECT platform_family, month_name AS busiest_month, games
FROM ranked
WHERE rn = 1
ORDER BY platform_family, month_number;


/* Q11. Longest gaps between consecutive releases */
WITH ordered AS (
    SELECT title,
           release_date,
           LAG(title)        OVER (ORDER BY release_date, title) AS previous_title,
           LAG(release_date) OVER (ORDER BY release_date, title) AS previous_release
    FROM games
)
SELECT TOP 5
       previous_title,
       previous_release,
       title AS next_title,
       release_date AS next_release,
       DATEDIFF(DAY, previous_release, release_date) AS days_between
FROM ordered
WHERE previous_release IS NOT NULL
ORDER BY days_between DESC;


/* Q12. Releases by quarter and the share released in the busy Q4 holiday season */
SELECT DATEPART(QUARTER, release_date) AS quarter,
       COUNT(*) AS games,
       CAST(100.0 * COUNT(*) / SUM(COUNT(*)) OVER () AS DECIMAL(5,1)) AS pct_of_year
FROM games
GROUP BY DATEPART(QUARTER, release_date)
ORDER BY quarter;
