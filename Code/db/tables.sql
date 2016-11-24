CREATE TABLE User (
	user_id SERIAL PRIMARY KEY,
	email_address VARCHAR(50),
	first_name VARCHAR(50),
	last_name VARCHAR (50),
	password VARCHAR (50)
 );


CREATE TABLE Venue (
	image VARCHAR(50),
	name VARCHAR (50),
	description TEXT,
	categories VARCHAR (50),
	location VARCHAR (50),
	capacity VARCHAR(50),
	pricing VARCHAR (50)
);