/* =====================================================================
   03_transform_and_load.sql
   ETL step: cleans the staging data, runs data-quality checks, then
   loads it into the normalised tables. Run after 02_load_staging.sql.
   ===================================================================== */

USE VideoGames2023;
GO

/* ---------- 1. Clean ---------- */
-- Remove stray spaces copied over from the spreadsheet
UPDATE stg_games
SET title      = TRIM(title),
    developer  = TRIM(developer),
    publisher  = TRIM(publisher),
    genre      = TRIM(genre),
    platforms  = TRIM(platforms);
GO

/* ---------- 2. Data-quality checks ----------
   Every check should return 0 issues before loading. */
SELECT 'Duplicate titles' AS check_name, COUNT(*) AS issues
FROM (SELECT title FROM stg_games GROUP BY title HAVING COUNT(*) > 1) AS dupes
UNION ALL
SELECT 'Missing required values', COUNT(*)
FROM stg_games
WHERE title IS NULL OR developer IS NULL OR publisher IS NULL
   OR genre IS NULL OR platforms IS NULL
UNION ALL
SELECT 'Invalid or non-2023 dates', COUNT(*)
FROM stg_games
WHERE TRY_CONVERT(DATE, release_date) IS NULL
   OR YEAR(TRY_CONVERT(DATE, release_date)) <> 2023
UNION ALL
SELECT 'Unknown platform codes', COUNT(*)
FROM stg_games AS s
CROSS APPLY STRING_SPLIT(s.platforms, ',') AS p
WHERE TRIM(p.value) NOT IN (SELECT platform_code FROM platforms);
GO

/* ---------- 3. Load lookup tables ---------- */
INSERT INTO developers (developer_name)
SELECT DISTINCT developer FROM stg_games;

INSERT INTO publishers (publisher_name)
SELECT DISTINCT publisher FROM stg_games;

INSERT INTO genres (genre_name)
SELECT DISTINCT genre FROM stg_games;
GO

/* ---------- 4. Load games ---------- */
INSERT INTO games (title, release_date, developer_id, publisher_id, genre_id)
SELECT s.title,
       CONVERT(DATE, s.release_date),
       d.developer_id,
       p.publisher_id,
       g.genre_id
FROM stg_games AS s
JOIN developers AS d ON d.developer_name = s.developer
JOIN publishers AS p ON p.publisher_name = s.publisher
JOIN genres     AS g ON g.genre_name     = s.genre;
GO

/* ---------- 5. Split the platform list into one row per game/platform ---------- */
INSERT INTO game_platforms (game_id, platform_id)
SELECT g.game_id, pl.platform_id
FROM stg_games AS s
JOIN games AS g ON g.title = s.title
CROSS APPLY STRING_SPLIT(s.platforms, ',') AS sp
JOIN platforms AS pl ON pl.platform_code = TRIM(sp.value);
GO

/* ---------- 6. Check row counts ---------- */
SELECT (SELECT COUNT(*) FROM stg_games)      AS staging_rows,
       (SELECT COUNT(*) FROM games)          AS games_loaded,
       (SELECT COUNT(*) FROM developers)     AS developers,
       (SELECT COUNT(*) FROM publishers)     AS publishers,
       (SELECT COUNT(*) FROM genres)         AS genres,
       (SELECT COUNT(*) FROM game_platforms) AS game_platform_links;
GO
