/* =====================================================================
   03_transform_and_load.sql
   ETL step: cleans the staging data, runs data-quality checks, then
   loads it into the normalised tables. Run after 02_load_staging.sql.
   ===================================================================== */

USE TVShows2026;
GO

/* ---------- 1. Clean ---------- */
UPDATE stg_shows
SET title         = TRIM(title),
    platform      = TRIM(platform),
    platform_type = TRIM(platform_type),
    format        = TRIM(format),
    genre         = TRIM(genre),
    subgenre      = NULLIF(TRIM(subgenre), ''),
    language      = TRIM(language);
GO

/* ---------- 2. Data-quality checks ----------
   Every check should return 0 issues before loading. */
SELECT 'Duplicate title/platform pairs' AS check_name, COUNT(*) AS issues
FROM (SELECT title, platform FROM stg_shows
      GROUP BY title, platform HAVING COUNT(*) > 1) AS dupes
UNION ALL
SELECT 'Missing required values', COUNT(*)
FROM stg_shows
WHERE title IS NULL OR platform IS NULL OR format IS NULL
   OR genre IS NULL OR language IS NULL
UNION ALL
SELECT 'Invalid or non-2026 dates', COUNT(*)
FROM stg_shows
WHERE TRY_CONVERT(DATE, premiere_date) IS NULL
   OR YEAR(TRY_CONVERT(DATE, premiere_date)) <> 2026
UNION ALL
SELECT 'Platforms with conflicting types', COUNT(*)
FROM (SELECT platform FROM stg_shows
      GROUP BY platform HAVING COUNT(DISTINCT platform_type) > 1) AS conflicts;
GO

/* ---------- 3. Load lookup tables ---------- */
INSERT INTO platforms (platform_name, platform_type)
SELECT DISTINCT platform, platform_type FROM stg_shows;

INSERT INTO genres (genre_name)
SELECT DISTINCT genre FROM stg_shows;

INSERT INTO languages (language_name)
SELECT DISTINCT language FROM stg_shows;
GO

/* ---------- 4. Load shows ---------- */
INSERT INTO shows (title, premiere_date, format, subgenre, platform_id, genre_id, language_id)
SELECT s.title,
       CONVERT(DATE, s.premiere_date),
       s.format,
       s.subgenre,
       p.platform_id,
       g.genre_id,
       l.language_id
FROM stg_shows AS s
JOIN platforms AS p ON p.platform_name = s.platform
JOIN genres    AS g ON g.genre_name    = s.genre
JOIN languages AS l ON l.language_name = s.language;
GO

/* ---------- 5. Reconcile row counts ---------- */
SELECT (SELECT COUNT(*) FROM stg_shows) AS staging_rows,
       (SELECT COUNT(*) FROM shows)     AS shows_loaded,
       (SELECT COUNT(*) FROM platforms) AS platforms,
       (SELECT COUNT(*) FROM genres)    AS genres,
       (SELECT COUNT(*) FROM languages) AS languages;
GO
