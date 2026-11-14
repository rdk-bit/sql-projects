/* =====================================================================
   02_load_staging.sql
   Loads the raw research data (data/tv_shows_2026.csv) into the staging
   table. Run after 01_create_tables.sql.
   ===================================================================== */

USE TVShows2026;
GO

TRUNCATE TABLE stg_shows;

INSERT INTO stg_shows (title, premiere_date, platform, platform_type, format, genre, subgenre, language) VALUES
    (N'Agatha Christie''s Seven Dials', N'2026-01-15', N'Netflix', N'Streaming', N'Scripted', N'Mystery', N'Mystery drama', N'English'),
    (N'Finding Her Edge', N'2026-01-22', N'Netflix', N'Streaming', N'Scripted', N'Drama', N'Sports teen drama', N'English'),
    (N'Free Bert', N'2026-01-22', N'Netflix', N'Streaming', N'Scripted', N'Comedy', N'Comedy', N'English'),
    (N'Being Gordon Ramsay', N'2026-02-18', N'Netflix', N'Streaming', N'Docuseries', N'Documentary', N'Restaurant industry', N'English'),
    (N'Strip Law', N'2026-02-20', N'Netflix', N'Streaming', N'Animation', N'Comedy', N'Adult animated sitcom', N'English'),
    (N'The Dinosaurs', N'2026-03-06', N'Netflix', N'Streaming', N'Docuseries', N'Documentary', N'Natural history', N'English'),
    (N'Age of Attraction', N'2026-03-11', N'Netflix', N'Streaming', N'Reality', N'Reality', N'Dating show', N'English'),
    (N'Dynasty: The Murdochs', N'2026-03-13', N'Netflix', N'Streaming', N'Docuseries', N'Documentary', N'Business', N'English'),
    (N'Something Very Bad Is Going to Happen', N'2026-03-26', N'Netflix', N'Streaming', N'Scripted', N'Horror', N'Horror', N'English'),
    (N'Jo Nesbø''s Detective Hole', N'2026-03-26', N'Netflix', N'Streaming', N'Scripted', N'Crime', N'Crime drama', N'Norwegian'),
    (N'Big Mistakes', N'2026-04-09', N'Netflix', N'Streaming', N'Scripted', N'Comedy', N'Crime comedy', N'English'),
    (N'Funny AF with Kevin Hart', N'2026-04-20', N'Netflix', N'Streaming', N'Reality', N'Reality', N'Stand-up comedy competition', N'English'),
    (N'Man on Fire', N'2026-04-30', N'Netflix', N'Streaming', N'Scripted', N'Thriller', N'Action thriller', N'English'),
    (N'Legends', N'2026-05-07', N'Netflix', N'Streaming', N'Scripted', N'Crime', N'Crime drama', N'English'),
    (N'Mating Season', N'2026-05-22', N'Netflix', N'Streaming', N'Animation', N'Comedy', N'Animated romantic comedy', N'English'),
    (N'Brazil 70: The Third Star', N'2026-05-29', N'Netflix', N'Streaming', N'Scripted', N'Drama', N'Historical sports drama', N'Portuguese'),
    (N'Human Vapor', N'2026-07-02', N'Netflix', N'Streaming', N'Scripted', N'Sci-Fi & Fantasy', N'Science fiction crime thriller', N'Japanese'),
    (N'Little House on the Prairie', N'2026-07-09', N'Netflix', N'Streaming', N'Scripted', N'Drama', N'Western historical drama', N'English'),
    (N'The Hawk', N'2026-07-16', N'Netflix', N'Streaming', N'Scripted', N'Comedy', N'Sports comedy', N'English'),
    (N'My Brilliant Career', N'2026-08-13', N'Netflix', N'Streaming', N'Scripted', N'Drama', N'Period drama', N'English'),
    (N'Wonka''s The Golden Ticket', N'2026-09-23', N'Netflix', N'Streaming', N'Reality', N'Reality', N'Reality competition', N'English'),
    (N'A Different World', N'2026-09-24', N'Netflix', N'Streaming', N'Scripted', N'Comedy', N'Sitcom', N'English'),
    (N'Steal', N'2026-01-21', N'Prime Video', N'Streaming', N'Scripted', N'Thriller', N'Heist thriller', N'English'),
    (N'Vaka', N'2026-01-30', N'Prime Video', N'Streaming', N'Scripted', N'Thriller', N'Dystopian thriller', N'Swedish'),
    (N'56 Days', N'2026-02-18', N'Prime Video', N'Streaming', N'Scripted', N'Thriller', N'Erotic thriller', N'English'),
    (N'Young Sherlock', N'2026-03-04', N'Prime Video', N'Streaming', N'Scripted', N'Mystery', N'Mystery thriller', N'English'),
    (N'Scarpetta', N'2026-03-11', N'Prime Video', N'Streaming', N'Scripted', N'Crime', N'Crime drama', N'English'),
    (N'Bait', N'2026-03-25', N'Prime Video', N'Streaming', N'Scripted', N'Comedy', N'Comedy', N'English'),
    (N'American Gladiators', N'2026-04-17', N'Prime Video', N'Streaming', N'Reality', N'Reality', N'Reality competition', N'English'),
    (N'Off Campus', N'2026-05-13', N'Prime Video', N'Streaming', N'Scripted', N'Romance', N'Young adult romance', N'English'),
    (N'Every Year After', N'2026-06-10', N'Prime Video', N'Streaming', N'Scripted', N'Romance', N'Romantic drama', N'English'),
    (N'Elle', N'2026-07-01', N'Prime Video', N'Streaming', N'Scripted', N'Comedy', N'Teen comedy drama', N'English'),
    (N'Sterling Point', N'2026-08-05', N'Prime Video', N'Streaming', N'Scripted', N'Drama', N'Teen drama', N'English'),
    (N'Neagley', N'2026-09-16', N'Prime Video', N'Streaming', N'Scripted', N'Crime', N'Crime drama', N'English'),
    (N'Carrie', N'2026-10-07', N'Prime Video', N'Streaming', N'Scripted', N'Horror', N'Supernatural horror', N'English'),
    (N'The Hunt', N'2026-03-04', N'Apple TV', N'Streaming', N'Scripted', N'Thriller', N'Thriller', N'French'),
    (N'Twisted Yoga', N'2026-03-13', N'Apple TV', N'Streaming', N'Docuseries', N'Documentary', N'True crime', N'English'),
    (N'Imperfect Women', N'2026-03-18', N'Apple TV', N'Streaming', N'Scripted', N'Thriller', N'Psychological thriller', N'English'),
    (N'Margo''s Got Money Troubles', N'2026-04-15', N'Apple TV', N'Streaming', N'Scripted', N'Comedy', N'Comedy drama', N'English'),
    (N'Widow''s Bay', N'2026-04-29', N'Apple TV', N'Streaming', N'Scripted', N'Horror', N'Horror comedy', N'English'),
    (N'Maximum Pleasure Guaranteed', N'2026-05-20', N'Apple TV', N'Streaming', N'Scripted', N'Comedy', N'Comedy thriller', N'English'),
    (N'Star City', N'2026-05-29', N'Apple TV', N'Streaming', N'Scripted', N'Sci-Fi & Fantasy', N'Alternate history science fiction', N'English'),
    (N'Cape Fear', N'2026-06-05', N'Apple TV', N'Streaming', N'Scripted', N'Thriller', N'Psychological thriller', N'English'),
    (N'Lucky', N'2026-07-15', N'Apple TV', N'Streaming', N'Scripted', N'Crime', N'Crime thriller', N'English'),
    (N'The Dynasty: UConn Huskies', N'2026-08-21', N'Apple TV', N'Streaming', N'Docuseries', N'Documentary', N'Sports', N'English'),
    (N'Last Seen', N'2026-09-09', N'Apple TV', N'Streaming', N'Scripted', N'Thriller', N'Thriller', N'English'),
    (N'Brothers', N'2026-09-23', N'Apple TV', N'Streaming', N'Scripted', N'Comedy', N'Comedy', N'English'),
    (N'Nocturne', N'2026-10-30', N'Apple TV', N'Streaming', N'Scripted', N'Crime', N'Crime drama', N'English'),
    (N'A Knight of the Seven Kingdoms', N'2026-01-18', N'HBO', N'Premium cable', N'Scripted', N'Sci-Fi & Fantasy', N'Fantasy', N'English'),
    (N'Neighbors', N'2026-02-13', N'HBO', N'Premium cable', N'Docuseries', N'Documentary', N'Interpersonal conflict', N'English'),
    (N'Banksters', N'2026-02-20', N'HBO Max', N'Streaming', N'Scripted', N'Thriller', N'Heist drama', N'German'),
    (N'Portobello', N'2026-02-20', N'HBO Max', N'Streaming', N'Scripted', N'Drama', N'Legal drama', N'Italian'),
    (N'DTF St. Louis', N'2026-03-01', N'HBO', N'Premium cable', N'Scripted', N'Comedy', N'Dark comedy', N'English'),
    (N'Rooster', N'2026-03-08', N'HBO', N'Premium cable', N'Scripted', N'Comedy', N'Comedy', N'English'),
    (N'Born to Bowl', N'2026-03-16', N'HBO', N'Premium cable', N'Docuseries', N'Documentary', N'Sports', N'English'),
    (N'The Beauty', N'2026-01-21', N'FX', N'Basic cable', N'Scripted', N'Horror', N'Science fiction body horror', N'English'),
    (N'Love Story', N'2026-02-12', N'FX', N'Basic cable', N'Scripted', N'Romance', N'Period romance anthology', N'English'),
    (N'The Testaments', N'2026-04-08', N'Hulu', N'Streaming', N'Scripted', N'Drama', N'Dystopian drama', N'English'),
    (N'Alice and Steve', N'2026-06-08', N'Hulu', N'Streaming', N'Scripted', N'Comedy', N'Comedy', N'English'),
    (N'Furious', N'2026-07-27', N'Hulu', N'Streaming', N'Scripted', N'Thriller', N'Crime thriller', N'English'),
    (N'The Shards', N'2026-08-05', N'Hulu', N'Streaming', N'Scripted', N'Thriller', N'Teen thriller', N'English'),
    (N'Phony', N'2026-10-20', N'Hulu', N'Streaming', N'Scripted', N'Comedy', N'Coming-of-age mystery comedy', N'English'),
    (N'Wonder Man', N'2026-01-27', N'Disney+', N'Streaming', N'Scripted', N'Comedy', N'Superhero comedy', N'English'),
    (N'O11CE: New Generation', N'2026-03-18', N'Disney+', N'Streaming', N'Scripted', N'Drama', N'Teen sports drama', N'Spanish'),
    (N'Star Wars: Maul – Shadow Lord', N'2026-04-06', N'Disney+', N'Streaming', N'Animation', N'Sci-Fi & Fantasy', N'Space opera', N'English'),
    (N'The Doomies', N'2026-06-26', N'Disney+', N'Streaming', N'Animation', N'Comedy', N'Supernatural adventure comedy', N'English'),
    (N'VisionQuest', N'2026-10-14', N'Disney+', N'Streaming', N'Scripted', N'Sci-Fi & Fantasy', N'Superhero action', N'English'),
    (N'The Greatest Average American', N'2026-02-25', N'ABC', N'Broadcast', N'Reality', N'Game Show', N'Game show', N'English'),
    (N'The Faithful: Women of the Bible', N'2026-03-22', N'Fox', N'Broadcast', N'Scripted', N'Drama', N'Biblical drama', N'English'),
    (N'Fear Factor: 48 Hours of Fear', N'2026-05-14', N'Fox', N'Broadcast', N'Reality', N'Reality', N'Reality competition', N'English');
GO

SELECT COUNT(*) AS rows_loaded FROM stg_shows;  -- expect 70
GO
