/* =====================================================================
   01_create_tables.sql
   Video Games of 2023: creates the database, table for the
   raw spreadsheet data, and the normalised tables it is loaded into.
   run this script FIRST(in bold for a reasonnnnnn)
   ===================================================================== */

IF DB_ID('VideoGames2023') IS NULL
    CREATE DATABASE VideoGames2023;
GO

USE VideoGames2023;
GO

-- Drop tables in dependency order so the script can be re-run
DROP TABLE IF EXISTS game_platforms;
DROP TABLE IF EXISTS games;
DROP TABLE IF EXISTS platforms;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS publishers;
DROP TABLE IF EXISTS developers;
DROP TABLE IF EXISTS stg_games;
GO

-- Excel, staging
CREATE TABLE stg_games (
    title         NVARCHAR(150),
    release_date  NVARCHAR(20),
    developer     NVARCHAR(100),
    publisher     NVARCHAR(100),
    genre         NVARCHAR(50),
    platforms     NVARCHAR(100)
);

/* ---------- Normalised tables ---------- */
CREATE TABLE developers (
    developer_id    INT IDENTITY(1,1) PRIMARY KEY,
    developer_name  NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE publishers (
    publisher_id    INT IDENTITY(1,1) PRIMARY KEY,
    publisher_name  NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE genres (
    genre_id    INT IDENTITY(1,1) PRIMARY KEY,
    genre_name  NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE platforms (
    platform_id      INT IDENTITY(1,1) PRIMARY KEY,
    platform_code    VARCHAR(10)  NOT NULL UNIQUE,   -- short code used in the spreadsheet
    platform_name    NVARCHAR(50) NOT NULL,
    platform_family  NVARCHAR(20) NOT NULL           -- PlayStation, Xbox, Nintendo or PC
);

CREATE TABLE games (
    game_id       INT IDENTITY(1,1) PRIMARY KEY,
    title         NVARCHAR(150) NOT NULL UNIQUE,
    release_date  DATE NOT NULL,                     -- first release on any platform
    developer_id  INT NOT NULL REFERENCES developers(developer_id),
    publisher_id  INT NOT NULL REFERENCES publishers(publisher_id),
    genre_id      INT NOT NULL REFERENCES genres(genre_id),
    CONSTRAINT chk_games_released_in_2023
        CHECK (release_date >= '2023-01-01' AND release_date < '2024-01-01')
);

-- Many-to-many: a game can release on several platforms
CREATE TABLE game_platforms (
    game_id      INT NOT NULL REFERENCES games(game_id),
    platform_id  INT NOT NULL REFERENCES platforms(platform_id),
    PRIMARY KEY (game_id, platform_id)
);
GO

/* ---------- Reference ---------- */
INSERT INTO platforms (platform_code, platform_name, platform_family) VALUES
    ('PS5', 'PlayStation 5',   'PlayStation'),
    ('PS4', 'PlayStation 4',   'PlayStation'),
    ('XSX', 'Xbox Series X|S', 'Xbox'),
    ('XB1', 'Xbox One',        'Xbox'),
    ('NS',  'Nintendo Switch', 'Nintendo'),
    ('PC',  'PC',              'PC');
GO
