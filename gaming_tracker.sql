-- ============================================================
-- GAMING TOURNAMENT TRACKER
-- DBMS Lab Project | Abdullah Akbar | 03-134242-005
-- BS(CS) 4-A | Instructor: Ms. Nadia Shakir
-- ============================================================

-- ============================================================
-- DDL: CREATE TABLES
-- ============================================================

CREATE TABLE IF NOT EXISTS Player (
    player_id  INTEGER PRIMARY KEY AUTOINCREMENT,
    username   TEXT UNIQUE NOT NULL,
    full_name  TEXT NOT NULL,
    email      TEXT UNIQUE NOT NULL,
    country    TEXT,
    rank_tier  TEXT CHECK(rank_tier IN ('Bronze','Silver','Gold','Platinum','Diamond')) DEFAULT 'Bronze'
);

CREATE TABLE IF NOT EXISTS Team (
    team_id      INTEGER PRIMARY KEY AUTOINCREMENT,
    team_name    TEXT UNIQUE NOT NULL,
    founded_date TEXT,
    captain_id   INTEGER,
    FOREIGN KEY (captain_id) REFERENCES Player(player_id)
);

CREATE TABLE IF NOT EXISTS Team_Player (
    player_id INTEGER NOT NULL,
    team_id   INTEGER NOT NULL,
    join_date TEXT,
    role      TEXT,
    PRIMARY KEY (player_id, team_id),
    FOREIGN KEY (player_id) REFERENCES Player(player_id),
    FOREIGN KEY (team_id)   REFERENCES Team(team_id)
);

CREATE TABLE IF NOT EXISTS Game (
    game_id       INTEGER PRIMARY KEY AUTOINCREMENT,
    game_title    TEXT NOT NULL,
    genre         TEXT,
    platform      TEXT,
    max_team_size INTEGER
);

CREATE TABLE IF NOT EXISTS Tournament (
    tournament_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    tournament_name TEXT NOT NULL,
    game_id         INTEGER,
    start_date      TEXT,
    end_date        TEXT,
    prize_pool      REAL,
    status          TEXT CHECK(status IN ('Upcoming','Ongoing','Completed')) DEFAULT 'Upcoming',
    FOREIGN KEY (game_id) REFERENCES Game(game_id)
);

CREATE TABLE IF NOT EXISTS Match (
    match_id       INTEGER PRIMARY KEY AUTOINCREMENT,
    tournament_id  INTEGER,
    team1_id       INTEGER,
    team2_id       INTEGER,
    match_date     TEXT,
    venue          TEXT,
    winner_team_id INTEGER,
    FOREIGN KEY (tournament_id)  REFERENCES Tournament(tournament_id),
    FOREIGN KEY (team1_id)       REFERENCES Team(team_id),
    FOREIGN KEY (team2_id)       REFERENCES Team(team_id),
    FOREIGN KEY (winner_team_id) REFERENCES Team(team_id)
);

CREATE TABLE IF NOT EXISTS Score (
    score_id      INTEGER PRIMARY KEY AUTOINCREMENT,
    match_id      INTEGER,
    team_id       INTEGER,
    points_scored INTEGER DEFAULT 0,
    is_winner     INTEGER DEFAULT 0,
    FOREIGN KEY (match_id) REFERENCES Match(match_id),
    FOREIGN KEY (team_id)  REFERENCES Team(team_id)
);

-- ============================================================
-- DML: INSERT SAMPLE DATA
-- ============================================================

-- Players (10 records)
INSERT INTO Player (username, full_name, email, country, rank_tier) VALUES
('xShadow',    'Ali Hassan',       'ali@mail.com',      'Pakistan',   'Diamond'),
('BladeX',     'Bilal Khan',       'bilal@mail.com',    'Pakistan',   'Platinum'),
('FireStorm',  'Sara Ahmed',       'sara@mail.com',     'Pakistan',   'Gold'),
('NightOwl',   'Umar Farooq',      'umar@mail.com',     'India',      'Gold'),
('ZeroGrav',   'Rania Siddiq',     'rania@mail.com',    'UAE',        'Silver'),
('GhostByte',  'Hamza Malik',      'hamza@mail.com',    'Pakistan',   'Platinum'),
('TurboX',     'Kamran Shah',      'kamran@mail.com',   'Pakistan',   'Bronze'),
('LazorEye',   'Farrukh Aziz',     'faz@mail.com',      'Uzbekistan', 'Diamond'),
('StormRider', 'Noor Bibi',        'noor@mail.com',     'Pakistan',   'Silver'),
('VoidWalker', 'Tariq Mehmood',    'tariq@mail.com',    'Pakistan',   'Gold');

-- Teams (10 records)
INSERT INTO Team (team_name, founded_date, captain_id) VALUES
('Alpha Squad',   '2023-01-15', 1),
('Blade Runners', '2023-03-10', 2),
('Storm Chasers', '2023-06-20', 3),
('Night Wolves',  '2022-11-05', 4),
('Zero Protocol', '2024-01-01', 5),
('Ghost Unit',    '2023-08-14', 6),
('Turbo Force',   '2024-02-28', 7),
('Lazor Squad',   '2022-09-09', 8),
('Storm Brigade', '2023-12-12', 9),
('Void Breakers', '2024-03-03', 10);

-- Team_Player assignments (10+ records)
INSERT INTO Team_Player (player_id, team_id, join_date, role) VALUES
(1, 1, '2023-01-15', 'Fragger'),
(2, 2, '2023-03-10', 'IGL'),
(3, 3, '2023-06-20', 'Support'),
(4, 4, '2022-11-05', 'Sniper'),
(5, 5, '2024-01-01', 'Entry'),
(6, 6, '2023-08-14', 'Lurker'),
(7, 7, '2024-02-28', 'Fragger'),
(8, 8, '2022-09-09', 'AWPer'),
(9, 9, '2023-12-12', 'Support'),
(10,10, '2024-03-03', 'IGL'),
(1, 6, '2023-09-01', 'Sub'),
(3, 1, '2023-02-01', 'Support'),
(4, 2, '2023-04-01', 'Sniper');

-- Games (4 records)
INSERT INTO Game (game_title, genre, platform, max_team_size) VALUES
('PUBG Mobile',     'Battle Royale', 'Mobile',  4),
('Valorant',        'Tactical FPS',  'PC',       5),
('FIFA 25',         'Sports',        'Console',  1),
('Call of Duty MW', 'FPS',           'PC',       5);

-- Tournaments (10 records)
INSERT INTO Tournament (tournament_name, game_id, start_date, end_date, prize_pool, status) VALUES
('PUBG Winter Cup 2025',     1, '2025-01-10', '2025-01-20', 50000.00, 'Completed'),
('Valorant Spring Open',     2, '2025-03-05', '2025-03-15', 75000.00, 'Completed'),
('FIFA Champions League',    3, '2025-04-01', '2025-04-10', 30000.00, 'Completed'),
('COD Summer Showdown',      4, '2025-06-15', '2025-06-25', 100000.00,'Completed'),
('PUBG Pro Series',          1, '2025-08-01', '2025-08-12', 80000.00, 'Completed'),
('Valorant Elite Series',    2, '2025-09-10', '2025-09-20', 60000.00, 'Ongoing'),
('PUBG Grand Prix',          1, '2026-01-05', '2026-01-15', 120000.00,'Completed'),
('Valorant World Qualifier', 2, '2026-03-01', '2026-03-10', 200000.00,'Ongoing'),
('COD Winter Invitational',  4, '2026-04-01', '2026-04-10', 90000.00, 'Upcoming'),
('FIFA Super Cup 2026',      3, '2026-05-01', '2026-05-10', 40000.00, 'Upcoming');

-- Matches (10 records)
INSERT INTO Match (tournament_id, team1_id, team2_id, match_date, venue, winner_team_id) VALUES
(1, 1, 2, '2025-01-12 18:00', 'Online Arena A', 1),
(1, 3, 4, '2025-01-13 19:00', 'Online Arena B', 3),
(2, 5, 6, '2025-03-07 20:00', 'LAN Center Karachi', 5),
(2, 7, 8, '2025-03-08 18:00', 'LAN Center Karachi', 8),
(3, 9, 10,'2025-04-03 17:00', 'Gaming Hub Lahore', 9),
(4, 1, 3, '2025-06-17 21:00', 'Online Arena A', 1),
(5, 2, 5, '2025-08-03 19:00', 'LAN Center Islamabad', 5),
(6, 6, 7, '2025-09-12 20:00', 'Online Arena C', 6),
(7, 8, 9, '2026-01-07 18:00', 'LAN Center Lahore', 8),
(8, 10,1, '2026-03-03 19:00', 'Online Arena A', 1);

-- Scores (2 per match = 20 records)
INSERT INTO Score (match_id, team_id, points_scored, is_winner) VALUES
(1,  1, 18, 1),(1,  2, 11, 0),
(2,  3, 22, 1),(2,  4,  9, 0),
(3,  5, 15, 1),(3,  6, 12, 0),
(4,  7, 10, 0),(4,  8, 16, 1),
(5,  9, 20, 1),(5, 10,  8, 0),
(6,  1, 25, 1),(6,  3, 14, 0),
(7,  2,  9, 0),(7,  5, 19, 1),
(8,  6, 17, 1),(8,  7, 13, 0),
(9,  8, 21, 1),(9,  9, 15, 0),
(10, 10,12, 0),(10, 1, 23, 1);

-- ============================================================
-- DML: UPDATE & DELETE EXAMPLES
-- ============================================================

UPDATE Player SET rank_tier = 'Diamond' WHERE username = 'BladeX';
UPDATE Tournament SET status = 'Completed' WHERE tournament_id = 6;

-- ============================================================
-- SELECT QUERIES
-- ============================================================

-- Q1: All players
SELECT * FROM Player;

-- Q2: INNER JOIN - matches with team names and tournament
SELECT m.match_id,
       t1.team_name AS team_1,
       t2.team_name AS team_2,
       tn.tournament_name,
       m.match_date,
       tw.team_name AS winner
FROM Match m
INNER JOIN Team t1 ON m.team1_id  = t1.team_id
INNER JOIN Team t2 ON m.team2_id  = t2.team_id
INNER JOIN Tournament tn ON m.tournament_id = tn.tournament_id
INNER JOIN Team tw ON m.winner_team_id = tw.team_id;

-- Q3: LEFT JOIN - all teams and their match count
SELECT t.team_name,
       COUNT(m.match_id) AS total_matches
FROM Team t
LEFT JOIN Match m ON t.team_id = m.team1_id OR t.team_id = m.team2_id
GROUP BY t.team_name
ORDER BY total_matches DESC;

-- Q4: RIGHT JOIN simulation (SQLite) - all tournaments even without matches
SELECT tn.tournament_name, COUNT(m.match_id) AS match_count
FROM Tournament tn
LEFT JOIN Match m ON tn.tournament_id = m.tournament_id
GROUP BY tn.tournament_name;

-- Q5: Aggregate - avg score per team
SELECT t.team_name,
       COUNT(s.score_id)     AS matches_played,
       SUM(s.points_scored)  AS total_points,
       ROUND(AVG(s.points_scored),2) AS avg_score,
       SUM(s.is_winner)      AS wins
FROM Score s
INNER JOIN Team t ON s.team_id = t.team_id
GROUP BY t.team_name
ORDER BY wins DESC, total_points DESC;

-- Q6: Aggregate - prize pool stats
SELECT COUNT(*)           AS total_tournaments,
       SUM(prize_pool)    AS total_prize_pool,
       AVG(prize_pool)    AS avg_prize,
       MAX(prize_pool)    AS biggest_tournament,
       MIN(prize_pool)    AS smallest_tournament
FROM Tournament;

-- Q7: Subquery - players on the most-winning team
SELECT p.username, p.full_name, p.rank_tier
FROM Player p
INNER JOIN Team_Player tp ON p.player_id = tp.player_id
WHERE tp.team_id = (
    SELECT team_id FROM Score
    WHERE is_winner = 1
    GROUP BY team_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- Q8: Subquery - tournaments with above-average prize pool
SELECT tournament_name, prize_pool, status
FROM Tournament
WHERE prize_pool > (SELECT AVG(prize_pool) FROM Tournament)
ORDER BY prize_pool DESC;

-- ============================================================
-- VIEWS
-- ============================================================

CREATE VIEW IF NOT EXISTS Leaderboard AS
SELECT t.team_name,
       SUM(s.is_winner)                        AS wins,
       SUM(CASE WHEN s.is_winner=0 THEN 1 ELSE 0 END) AS losses,
       SUM(s.points_scored)                    AS total_points,
       ROUND(AVG(s.points_scored),1)           AS avg_score
FROM Team t
LEFT JOIN Score s ON t.team_id = s.team_id
GROUP BY t.team_name
ORDER BY wins DESC, total_points DESC;

CREATE VIEW IF NOT EXISTS Player_Profile AS
SELECT p.player_id, p.username, p.full_name, p.country, p.rank_tier,
       t.team_name, tp.role
FROM Player p
LEFT JOIN Team_Player tp ON p.player_id = tp.player_id
LEFT JOIN Team t ON tp.team_id = t.team_id;

-- Query the views
SELECT * FROM Leaderboard;
SELECT * FROM Player_Profile;
