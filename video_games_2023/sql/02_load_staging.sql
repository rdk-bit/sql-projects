/* =====================================================================
   02_load_staging.sql
   Loads the raw spreadsheet data (data/games_2023.csv) into the staging
   table exactly as it appears in the sheet. Run after 01_create_tables.sql.
   ===================================================================== */

USE VideoGames2023;
GO

TRUNCATE TABLE stg_games;

INSERT INTO stg_games (title, release_date, developer, publisher, genre, platforms) VALUES
    (N'Dead Space', N'2023-01-27', N'Motive Studio', N'Electronic Arts', N'Survival horror', N'PS5, XSX, PC'),
    (N'Fire Emblem Engage', N'2023-01-20', N'Intelligent Systems', N'Nintendo', N'Strategy', N'NS'),
    (N'Hi-Fi Rush', N'2023-01-25', N'Tango Gameworks', N'Bethesda Softworks', N'Action', N'XSX, PC'),
    (N'Pizza Tower', N'2023-01-26', N'Tour De Pizza', N'Tour De Pizza', N'Platformer', N'PC'),
    (N'Hogwarts Legacy', N'2023-02-10', N'Avalanche Software', N'Warner Bros. Games', N'Action RPG', N'PS5, PS4, XSX, XB1, NS, PC'),
    (N'Wild Hearts', N'2023-02-17', N'Omega Force', N'Electronic Arts', N'Action', N'PS5, XSX, PC'),
    (N'Atomic Heart', N'2023-02-21', N'Mundfish', N'Focus Entertainment', N'Shooter', N'PS5, PS4, XSX, XB1, PC'),
    (N'Wo Long: Fallen Dynasty', N'2023-03-03', N'Team Ninja', N'Koei Tecmo', N'Action RPG', N'PS5, PS4, XSX, XB1, PC'),
    (N'Resident Evil 4', N'2023-03-24', N'Capcom', N'Capcom', N'Survival horror', N'PS5, PS4, XSX, PC'),
    (N'Dredge', N'2023-03-30', N'Black Salt Games', N'Team17', N'Adventure', N'NS, PS5, PS4, XSX, XB1, PC'),
    (N'Star Wars Jedi: Survivor', N'2023-04-28', N'Respawn Entertainment', N'Electronic Arts', N'Action-adventure', N'PS5, XSX, PC'),
    (N'Redfall', N'2023-05-02', N'Arkane Austin', N'Bethesda Softworks', N'Shooter', N'XSX, PC'),
    (N'The Legend of Zelda: Tears of the Kingdom', N'2023-05-12', N'Nintendo EPD', N'Nintendo', N'Action-adventure', N'NS'),
    (N'Street Fighter 6', N'2023-06-02', N'Capcom', N'Capcom', N'Fighting', N'PS5, PS4, XSX, PC'),
    (N'Diablo IV', N'2023-06-06', N'Blizzard Entertainment', N'Blizzard Entertainment', N'Action RPG', N'PS5, PS4, XSX, XB1, PC'),
    (N'Final Fantasy XVI', N'2023-06-22', N'Square Enix', N'Square Enix', N'Action RPG', N'PS5'),
    (N'Dave the Diver', N'2023-06-28', N'Mintrocket', N'Nexon', N'Adventure', N'PC, NS'),
    (N'Pikmin 4', N'2023-07-21', N'Nintendo EPD', N'Nintendo', N'Strategy', N'NS'),
    (N'Remnant II', N'2023-07-25', N'Gunfire Games', N'Gearbox Publishing', N'Shooter', N'PS5, XSX, PC'),
    (N'Baldur''s Gate 3', N'2023-08-03', N'Larian Studios', N'Larian Studios', N'RPG', N'PC, PS5, XSX'),
    (N'Bomb Rush Cyberfunk', N'2023-08-18', N'Team Reptile', N'Team Reptile', N'Action', N'PC, NS'),
    (N'Armored Core VI: Fires of Rubicon', N'2023-08-25', N'FromSoftware', N'Bandai Namco Entertainment', N'Action', N'PS5, PS4, XSX, XB1, PC'),
    (N'Sea of Stars', N'2023-08-29', N'Sabotage Studio', N'Sabotage Studio', N'RPG', N'NS, PS5, PS4, XSX, XB1, PC'),
    (N'Starfield', N'2023-09-06', N'Bethesda Game Studios', N'Bethesda Softworks', N'RPG', N'XSX, PC'),
    (N'Lies of P', N'2023-09-19', N'Round8 Studio', N'Neowiz', N'Action RPG', N'PS5, PS4, XSX, XB1, PC'),
    (N'Mortal Kombat 1', N'2023-09-19', N'NetherRealm Studios', N'Warner Bros. Games', N'Fighting', N'PS5, XSX, NS, PC'),
    (N'Cocoon', N'2023-09-29', N'Geometric Interactive', N'Annapurna Interactive', N'Puzzle', N'NS, PS5, PS4, XSX, XB1, PC'),
    (N'Assassin''s Creed Mirage', N'2023-10-05', N'Ubisoft Bordeaux', N'Ubisoft', N'Action-adventure', N'PS5, PS4, XSX, XB1, PC'),
    (N'Forza Motorsport', N'2023-10-10', N'Turn 10 Studios', N'Xbox Game Studios', N'Racing', N'XSX, PC'),
    (N'Lords of the Fallen', N'2023-10-13', N'Hexworks', N'CI Games', N'Action RPG', N'PS5, XSX, PC'),
    (N'Marvel''s Spider-Man 2', N'2023-10-20', N'Insomniac Games', N'Sony Interactive Entertainment', N'Action-adventure', N'PS5'),
    (N'Super Mario Bros. Wonder', N'2023-10-20', N'Nintendo EPD', N'Nintendo', N'Platformer', N'NS'),
    (N'Lethal Company', N'2023-10-23', N'Zeekerss', N'Zeekerss', N'Survival horror', N'PC'),
    (N'Cities: Skylines II', N'2023-10-24', N'Colossal Order', N'Paradox Interactive', N'Simulation', N'PC'),
    (N'Alan Wake 2', N'2023-10-27', N'Remedy Entertainment', N'Epic Games Publishing', N'Survival horror', N'PS5, XSX, PC'),
    (N'The Talos Principle 2', N'2023-11-02', N'Croteam', N'Devolver Digital', N'Puzzle', N'PS5, XSX, PC'),
    (N'Like a Dragon Gaiden: The Man Who Erased His Name', N'2023-11-09', N'Ryu Ga Gotoku Studio', N'Sega', N'Action-adventure', N'PS5, PS4, XSX, XB1, PC'),
    (N'Super Mario RPG', N'2023-11-17', N'ArtePiazza', N'Nintendo', N'RPG', N'NS'),
    (N'Persona 5 Tactica', N'2023-11-17', N'Atlus', N'Sega', N'Strategy', N'NS, PS5, PS4, XSX, XB1, PC'),
    (N'Avatar: Frontiers of Pandora', N'2023-12-07', N'Massive Entertainment', N'Ubisoft', N'Action-adventure', N'PS5, XSX, PC');
GO

SELECT COUNT(*) AS rows_loaded FROM stg_games;  -- expect 40
GO
