/* =====================================================================
   04_analysis_queries.sql
   Business questions answered with SQL. Run each query on its own.
   ===================================================================== */

USE TVShows2026;
GO

/* Q1. Which platforms launched the most new shows, and what share of the total? */
SELECT p.platform_name,
       p.platform_type,
       COUNT(*) AS new_shows,
       CAST(100.0 * COUNT(*) / SUM(COUNT(*)) OVER () AS DECIMAL(5,1)) AS pct_of_total,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS platform_rank
FROM shows AS s
JOIN platforms AS p ON p.platform_id = s.platform_id
GROUP BY p.platform_name, p.platform_type
ORDER BY platform_rank, p.platform_name;


/* Q2. Streaming vs traditional TV: premieres by platform type */
SELECT p.platform_type,
       COUNT(*) AS new_shows,
       COUNT(DISTINCT p.platform_id) AS platforms
FROM shows AS s
JOIN platforms AS p ON p.platform_id = s.platform_id
GROUP BY p.platform_type
ORDER BY new_shows DESC;


/* Q3. Premieres per month, with a running total */
WITH monthly AS (
    SELECT MONTH(premiere_date)            AS month_number,
           DATENAME(MONTH, premiere_date)  AS month_name,
           COUNT(*)                        AS premieres
    FROM shows
    GROUP BY MONTH(premiere_date), DATENAME(MONTH, premiere_date)
)
SELECT month_number,
       month_name,
       premieres,
       SUM(premieres) OVER (ORDER BY month_number) AS cumulative_premieres
FROM monthly
ORDER BY month_number;



/* Q4. Format mix by platform (pivot with conditional aggregation) */
SELECT p.platform_name,
       SUM(CASE WHEN s.format = 'Scripted'   THEN 1 ELSE 0 END) AS scripted,
       SUM(CASE WHEN s.format = 'Animation'  THEN 1 ELSE 0 END) AS animation,
       SUM(CASE WHEN s.format = 'Docuseries' THEN 1 ELSE 0 END) AS docuseries,
       SUM(CASE WHEN s.format = 'Reality'    THEN 1 ELSE 0 END) AS reality,
       COUNT(*) AS total
FROM shows AS s
JOIN platforms AS p ON p.platform_id = s.platform_id
GROUP BY p.platform_name
ORDER BY total DESC, p.platform_name;


/* Q5. Most popular genres overall */
SELECT g.genre_name,
       COUNT(*) AS new_shows,
       CAST(100.0 * COUNT(*) / SUM(COUNT(*)) OVER () AS DECIMAL(5,1)) AS pct_of_total
FROM shows AS s
JOIN genres AS g ON g.genre_id = s.genre_id
GROUP BY g.genre_name
ORDER BY new_shows DESC, g.genre_name;


/* Q6. Each platform's most common genre (ties shown) */
WITH platform_genres AS (
    SELECT p.platform_name,
           g.genre_name,
           COUNT(*) AS shows,
           RANK() OVER (PARTITION BY p.platform_name ORDER BY COUNT(*) DESC) AS genre_rank
    FROM shows AS s
    JOIN platforms AS p ON p.platform_id = s.platform_id
    JOIN genres AS g    ON g.genre_id = s.genre_id
    GROUP BY p.platform_name, g.genre_name
)
SELECT platform_name, genre_name AS top_genre, shows
FROM platform_genres
WHERE genre_rank = 1
ORDER BY platform_name, genre_name;


/* Q7. Non-English shows on each platform */
SELECT p.platform_name,
       COUNT(*) AS total_shows,
       SUM(CASE WHEN l.language_name <> 'English' THEN 1 ELSE 0 END) AS non_english_shows,
       CAST(100.0 * SUM(CASE WHEN l.language_name <> 'English' THEN 1 ELSE 0 END)
            / COUNT(*) AS DECIMAL(5,1)) AS pct_non_english
FROM shows AS s
JOIN platforms AS p ON p.platform_id = s.platform_id
JOIN languages AS l ON l.language_id = s.language_id
GROUP BY p.platform_name
ORDER BY pct_non_english DESC, p.platform_name;


/* Q8. Which day of the week do new shows premiere on? */
SELECT DATENAME(WEEKDAY, premiere_date) AS weekday,
       COUNT(*) AS premieres
FROM shows
GROUP BY DATENAME(WEEKDAY, premiere_date)
ORDER BY premieres DESC;


/* Q9. Release cadence: average days between new shows on each platform */
WITH gaps AS (
    SELECT p.platform_name,
           s.premiere_date,
           DATEDIFF(DAY,
                    LAG(s.premiere_date) OVER (PARTITION BY p.platform_name ORDER BY s.premiere_date),
                    s.premiere_date) AS days_since_previous
    FROM shows AS s
    JOIN platforms AS p ON p.platform_id = s.platform_id
)
SELECT platform_name,
       COUNT(*) AS new_shows,
       CAST(AVG(1.0 * days_since_previous) AS DECIMAL(6,1)) AS avg_days_between_premieres,
       MAX(days_since_previous) AS longest_gap_days
FROM gaps
GROUP BY platform_name
HAVING COUNT(*) >= 3
ORDER BY avg_days_between_premieres;


/* Q10. First and most recent new show on each platform */
WITH ordered AS (
    SELECT p.platform_name,
           s.title,
           s.premiere_date,
           ROW_NUMBER() OVER (PARTITION BY p.platform_name ORDER BY s.premiere_date, s.title)           AS first_rn,
           ROW_NUMBER() OVER (PARTITION BY p.platform_name ORDER BY s.premiere_date DESC, s.title DESC) AS last_rn
    FROM shows AS s
    JOIN platforms AS p ON p.platform_id = s.platform_id
)
SELECT f.platform_name,
       f.title AS first_new_show,  f.premiere_date AS first_premiere,
       l.title AS latest_new_show, l.premiere_date AS latest_premiere
FROM ordered AS f
JOIN ordered AS l ON l.platform_name = f.platform_name AND l.last_rn = 1
WHERE f.first_rn = 1
ORDER BY f.platform_name;



