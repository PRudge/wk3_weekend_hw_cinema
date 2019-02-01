DROP TABLE tickets;
-- DROP TABLE screenings;
DROP TABLE films;
DROP TABLE customers;

CREATE TABLE customers (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  funds FLOAT(8)
);

CREATE TABLE films (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  price FLOAT(8)
);

CREATE TABLE tickets (
  id SERIAL4 PRIMARY KEY,
  customer_id INT REFERENCES customers(id) ON DELETE CASCADE,
  film_id INT REFERENCES films(id) ON DELETE CASCADE
);

-- CREATE TABLE screenings (
--   id SERIAL4 PRIMARY KEY,
--   film_id INT REFERENCES films(id) ON DELETE CASCADE,
--   screen_time VARCHAR(255),
--   max_capacity INT
-- );
