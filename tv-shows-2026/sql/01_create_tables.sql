/* =====================================================================
   01_create_tables.sql
   New TV Shows of 2026: creates the database, a staging table for the
   raw research data, and the normalised tables it is loaded into.
   Run this script first. Re-running it resets the whole database.
   Requires SQL Server 2017 or later (SQL Server Express is free).
   ===================================================================== */

IF DB_ID('TVShows2026') IS NULL
    CREATE DATABASE TVShows2026;
GO

USE TVShows2026;
GO

-- Drop tables in dependency order so the script can be re-run
DROP TABLE IF EXISTS shows;
DROP TABLE IF EXISTS platforms;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS languages;
DROP TABLE IF EXISTS stg_shows;
GO

/* ---------- Staging ----------
   One row per show exactly as collected, with every column stored as text. */
CREATE TABLE stg_shows (
    title          NVARCHAR(150),
    premiere_date  NVARCHAR(20),
    platform       NVARCHAR(50),
    platform_type  NVARCHAR(30),
    format         NVARCHAR(30),
    genre          NVARCHAR(50),
    subgenre       NVARCHAR(100),
    language       NVARCHAR(30)
);

/* ---------- Normalised tables ---------- */
CREATE TABLE platforms (
    platform_id    INT IDENTITY(1,1) PRIMARY KEY,
    platform_name  NVARCHAR(50) NOT NULL UNIQUE,
    platform_type  NVARCHAR(30) NOT NULL
        CHECK (platform_type IN ('Streaming', 'Broadcast', 'Basic cable', 'Premium cable'))
);

CREATE TABLE genres (
    genre_id    INT IDENTITY(1,1) PRIMARY KEY,
    genre_name  NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE languages (
    language_id    INT IDENTITY(1,1) PRIMARY KEY,
    language_name  NVARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE shows (
    show_id        INT IDENTITY(1,1) PRIMARY KEY,
    title          NVARCHAR(150) NOT NULL,
    premiere_date  DATE NOT NULL,                 -- series premiere (first episode)
    format         NVARCHAR(30) NOT NULL
        CHECK (format IN ('Scripted', 'Animation', 'Docuseries', 'Reality')),
    subgenre       NVARCHAR(100) NULL,
    platform_id    INT NOT NULL REFERENCES platforms(platform_id),
    genre_id       INT NOT NULL REFERENCES genres(genre_id),
    language_id    INT NOT NULL REFERENCES languages(language_id),
    CONSTRAINT uq_show_per_platform UNIQUE (title, platform_id),
    CONSTRAINT chk_premiered_in_2026
        CHECK (premiere_date >= '2026-01-01' AND premiere_date < '2027-01-01')
);
GO
