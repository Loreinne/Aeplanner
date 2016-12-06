CREATE TABLE App_user (
	user_id SERIAL PRIMARY KEY,
	email_address VARCHAR(50),
	fname VARCHAR(50),
	lname VARCHAR (50),
	password VARCHAR (50),
	birthdate date,
	age VARCHAR(5),
	is_active BOOLEAN DEFAULT TRUE,
 );


CREATE TABLE Venue (
	id SERIAL PRIMARY KEY,
	image VARCHAR(50),
	name VARCHAR (50),
	description TEXT,
	categories VARCHAR (50),
	location VARCHAR (50),
	capacity VARCHAR(50),
	pricing VARCHAR (50),
	cat_id INT references Categories(id),
	is_active BOOLEAN
);

CREATE TABLE Catering_services (
	id SERIAL PRIMARY KEY,
	image VARCHAR(50),
	name VARCHAR (50),
	description TEXT,
	categories VARCHAR (50),
	location VARCHAR (50),
	capacity VARCHAR(50),
	pricing VARCHAR (50),
	cat_id INT references Categories(id),
	is_active BOOLEAN
);

CREATE TABLE Proposal (
	id		serial primary key,
	name	text,
	address text,
	proposal_num VARCHAR(50),
	proposal_name text,
	proposal_date date
);

CREATE TABLE Contract (
	id		serial primary key,
	reference	text,
	client_name text,
	termsOfAgreement text, 
);


CREATE TABLE Event (
	id serial primary key,
	title VARCHAR(50),
	date_event date,
	time_event time,
	con_id INT references Contract(id),
	no_id INT references Note(id),
	app_id INT references Appointment(id)
);

CREATE TABLE Note (
	id  serial primary key,
	title VARCHAR (50),
	note Text
);

CREATE TABLE Appointment (
	id serial primary key,
	title VARCHAR(50),
	app_date date,
	app_time time

);

CREATE TABLE Categories (
	id serial primary key,
	name VARCHAR(50)
);