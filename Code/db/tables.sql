CREATE TABLE User (
	user_id SERIAL PRIMARY KEY,
	email_address VARCHAR(50),
	first_name VARCHAR(50),
	last_name VARCHAR (50),
	password VARCHAR (50)
 );


CREATE TABLE Venue (
	V_image VARCHAR(50),
	V_name VARCHAR (50),
	V_description TEXT,
	V_categories VARCHAR (50),
	V_location VARCHAR (50),
	V_capacity VARCHAR(50),
	V_pricing VARCHAR (50)
);


CREATE TABLE Catering_services (
	c_image VARCHAR(50),
	c_name VARCHAR (50),
	c_description TEXT,
	c_categories VARCHAR (50),
	c_location VARCHAR (50),
	c_capacity VARCHAR(50),
	c_pricing VARCHAR (50)
);