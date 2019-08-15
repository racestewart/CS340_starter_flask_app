--------------------------------------------------------------------------------
-- 1.) GET QUERIES -------------------------------------------------------------
-- GET ALL GAME INFO -----------------------------------------------------------
SELECT id, name, release_date, price FROM Game
WHERE id = :id OR name = :name;
-- GET ALL GENRE INFO ----------------------------------------------------------
SELECT id, genre FROM Genre
WHERE id = :id OR genre = :genre;
-- GET ALL STUDIO INFO ---------------------------------------------------------
SELECT id, name FROM Studio
WHERE id = :id OR name = :name;
-- GET ALL CONSOLE INFO --------------------------------------------------------
SELECT id, name FROM Console
WHERE id = :id OR name = :name;
-- GET ALL PUBLISHER INFO ------------------------------------------------------
SELECT id, name FROM Publisher
WHERE id = :id OR name = :name;
-- GET ALL CONECTIONS ----------------------------------------------------------
SELECT g.name AS 'GAME TITLE', g.release_date AS 'RELEASE DATE', g.price AS 'CURRENT PRICE',
  e.genre AS 'GAME GENRE', c.name AS 'AVAILABLE PLATFORMS',
  s.name AS 'CREATED BY', p.name AS'PUBLISHED BY'
  FROM Game g
  LEFT JOIN Game_Genre AS gage ON g.id = gage.game_id
  LEFT JOIN Genre AS e ON gage.genre_id = e.id
  LEFT JOIN Game_Company AS gaco ON g.id = gaco.game_id
  LEFT JOIN Studio AS s ON gaco.studio_id = s.id
  LEFT JOIN Publisher AS p ON gaco.publisher_id = p.id
  LEFT JOIN Game_Console AS gaca ON g.id = gaca.game_id
  LEFT JOIN Console AS c ON gaca.console_id = c.id
  ORDER BY g.name ASC;

--------------------------------------------------------------------------------
-- 2.) INSERT QUERIES ----------------------------------------------------------
-- ADD NEW GAME ----------------------------------------------------------------
INSERT INTO Game (id,name,release_date,price) VALUES (
  :id,
  :name,
  :release_date,
  :price
);
-- ADD NEW GENRE ---------------------------------------------------------------
INSERT INTO Genre (id,genre) VALUES (
  :id,
  :genre
);
-- ADD NEW STUDIO --------------------------------------------------------------
INSERT INTO Studio (id,name) VALUES (
  :id,
  :name
);
-- ADD NEW CONSOLE -------------------------------------------------------------
INSERT INTO Console (id,name) VALUES (
  :id,
  :name
);
-- ADD NEW PUBLISHER -----------------------------------------------------------
INSERT INTO Publisher (id,name) VALUES (
  :id,
  :name
);
-- ADD NEW GAME GENRE CONNECTION -----------------------------------------------
INSERT INTO Game_Genre (id,game_id,genre_id) VALUES (
  :id,
  :game_id,
  :genre_id
);
-- ADD NEW GAME STUDIO CONNECTION ----------------------------------------------
INSERT INTO Game_Company (id,game_id,studio_id,publisher_id) VALUES (
  :id,
  :game_id,
  :studio_id,
  :publisher_id
);
-- ADD NEW GAME CONSOLE CONNECTION ---------------------------------------------
INSERT INTO Game_Console (id,game_id,console_id) VALUES (
  :id,
  :game_id,
  :console_id
);


--------------------------------------------------------------------------------
-- 3.) UPDATE QUERIES ----------------------------------------------------------
-- CHANGE GAME DETAILS ---------------------------------------------------------
UPDATE Game SET
  id = :id,
  name = :name,
  release_date = :release_date,
  price = :price
WHERE id = :id OR name = :name;
-- CHANGE GAME GENRE DETAILS ---------------------------------------------------
UPDATE Game_Genre SET
  game_id = :game_id,
  genre_id = :genre_id
WHERE game_id = :game_id AND genre_id = :genre_id;
-- CHANGE GAME STUDIO DETAILS --------------------------------------------------
UPDATE Game_Company SET
  game_id = :game_id,
  studio_id = :studio_id,
  publisher_id = :publisher_id
WHERE (game_id = :game_id AND studio_id = :studio_id) OR (game_id = :game_id AND publisher_id = :publisher_id);
-- CHANGE GAME CONSOLE DETAILS -------------------------------------------------
UPDATE Game_Console SET
  game_id = :game_id,
  console_id = :console_id
WHERE game_id = :game_id AND console_id = :console_id;


--------------------------------------------------------------------------------
-- 4.) DELETE QUERIES ----------------------------------------------------------
-- DELETE GAME -----------------------------------------------------------------
DELETE FROM Game WHERE gam = :name;
-- DELETE GENRE ----------------------------------------------------------------
DELETE FROM Genre WHERE gen = :genre;
-- DELETE STUDIO ---------------------------------------------------------------
DELETE FROM Studio WHERE stu = :name;
-- DELETE CONSOLE --------------------------------------------------------------
DELETE FROM Console WHERE con = :name;
-- DELETE PUBLISHER ------------------------------------------------------------
DELETE FROM Publisher WHERE pub = :name;
-- DELETE GAME GENRE CONNECTION ------------------------------------------------
DELETE FROM Game_Genre WHERE gam = :game_id AND gen = :genre_id;
-- DELETE GAME STUDIO CONNECTION -----------------------------------------------
DELETE FROM Game_Company WHERE (gam = :game_id AND stu = :studio_id) OR (gam = :game_id AND pub = :publisher_id);
-- DELETE GAME CONSOLE CONNECTION ----------------------------------------------
DELETE FROM Game_Console WHERE gam = :game_id AND con = :console_id;
