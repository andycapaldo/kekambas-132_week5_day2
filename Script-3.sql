-- Create Customer Table

CREATE TABLE IF NOT EXISTS customers(
	customer_id SERIAL PRIMARY KEY,
	full_name VARCHAR(100) NOT NULL,
	date_visited TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Create Tickets Table

CREATE TABLE IF NOT EXISTS tickets(
	ticket_id SERIAL PRIMARY KEY,
	price FLOAT(2) NOT NULL,
	customer_id INTEGER NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customers(customer_id) 
);

-- Create Movies Table

CREATE TABLE IF NOT EXISTS movies(
	movie_id SERIAL PRIMARY KEY,
	title VARCHAR(50),
	description VARCHAR(100)
);


-- ALTER TABLE ADD COLUMN to add movie_id to tickets table

ALTER TABLE tickets
ADD COLUMN movie_id INTEGER UNIQUE NOT NULL;

-- ADD FOREIGN KEY to movie_id column in tickets table to connect to movies table

ALTER TABLE tickets
ADD FOREIGN KEY(movie_id) REFERENCES movies(movie_id);


-- Create Movie Showings Table

CREATE TABLE IF NOT EXISTS movie_showings(
	movie_id INTEGER UNIQUE NOT NULL,
	theatre_id INTEGER UNIQUE NOT NULL,
	showtimes TIME
);

ALTER TABLE movie_showings 
DROP COLUMN showtimes;  -- Had TO DELETE COLUMN showtimes since I did NOT INITIALLY ADD UNIQUE constraint

ALTER TABLE movie_showings 
ADD COLUMN showtimes TIME UNIQUE NOT NULL;

-- ADD FOREIGN KEY to movie_id column in movie_showings table to connect to movies table
ALTER TABLE movie_showings 
ADD FOREIGN KEY(movie_id) REFERENCES movies(movie_id);


-- Create Theatres table

CREATE TABLE IF NOT EXISTS theatres(
	theatre_id SERIAL PRIMARY KEY,
	IMAX BOOL,
	movie_id INTEGER UNIQUE NOT NULL,
	FOREIGN KEY(movie_id) REFERENCES movies(movie_id),
	showtimes TIME UNIQUE NOT NULL
);

-- Finally, we ADD FOREIGN KEYS for theatre_id and showtimes to the movie_showings table
ALTER TABLE movie_showings 
ADD FOREIGN KEY(showtimes) REFERENCES theatres(showtimes);


ALTER TABLE movie_showings 
ADD FOREIGN KEY(theatre_id) REFERENCES theatres(theatre_id);


