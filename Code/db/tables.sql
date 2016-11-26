
CREATE TABLE User (
	user_id SERIAL PRIMARY KEY,
	email_address VARCHAR(50),
	first_name VARCHAR(50),
	last_name VARCHAR (50),
	password VARCHAR (50)
 );


CREATE TABLE Venue (
	V_id SERIAL PRIMARY KEY,
	V_image VARCHAR(50),
	V_name VARCHAR (50),
	V_description TEXT,
	V_categories VARCHAR (50),
	V_location VARCHAR (50),
	V_capacity VARCHAR(50),
	V_pricing VARCHAR (50)
);


CREATE TABLE Catering_services (
	c_id SERIAL PRIMARY KEY,
	c_image VARCHAR(50),
	c_name VARCHAR (50),
	c_description TEXT,
	c_categories VARCHAR (50),
	c_location VARCHAR (50),
	c_capacity VARCHAR(50),
	c_pricing VARCHAR (50)

CREATE TABLE Proposal (
	id		serial primary key,
	name	text,
	address text,
	proposal_num int,
	proposal_name text,
	proposal_date date
);

CREATE TABLE Contract (
	id		serial primary key,
	reference	text,
	client_name text,
	termsOfAgreement text
);


CREATE TABLE Event (
	e_id serial primary key
	e_title VARCHAR(50),
	e_date date,
	e_time time
);

CREATE TABLE Note (
	n_id  serial primary key,
	n_title VARCH(50),
	n_note Text
);

CREATE TABLE Appointment (
	a_id serial primary key
	a_title VARCHAR(50),
	a_date date,
	a_time time

);