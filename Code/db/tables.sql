CREATE TABLE App_user (
	user_id SERIAL PRIMARY KEY,
	email_address VARCHAR(50),
	fname VARCHAR(50),
	lname VARCHAR (50),
	password VARCHAR (50),
	birthdate date,
	age VARCHAR(5),
	is_active BOOLEAN DEFAULT TRUE
 );


CREATE TABLE Venue (
	id SERIAL PRIMARY KEY,
	image VARCHAR(50),
	name VARCHAR (50),
	email_address VARCHAR(50),
	description TEXT,
	cat_id INT references Categories(id),
	location VARCHAR (50),
	capacity VARCHAR(50),
	pricing VARCHAR (50),
	is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE Catering_services (
	id SERIAL PRIMARY KEY,
	image VARCHAR(50),
	name VARCHAR (50),
	email_address VARCHAR(50),
	description TEXT,
	categories VARCHAR (50),
	location VARCHAR (50),
	capacity VARCHAR(50),
	pricing VARCHAR (50),
	cat_id INT references Categories(id),
	is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE Proposal (
	id		serial primary key,
	name	text,
	address text,
	proposal_num VARCHAR(50),
	proposal_name text,
	proposal_date date,
	event_id INT reference Event(id)
); 

CREATE TABLE Contract (
	id		serial primary key,
	reference	text,
	client_name text,
	termsOfAgreement text,
	event_id INT references Event(id)
);


CREATE TABLE Event (
	id serial primary key,
	title VARCHAR(50),
	date_event date,
	time_event time,
	user_id INT references App_user(id)
);

CREATE TABLE Note (
	id  serial primary key,
	title VARCHAR (50),
	note Text,
	event_id INT references Event(id)
);

CREATE TABLE Appointment (
	id serial primary key,
	title VARCHAR(50),
	app_date date,
	app_time time,
	event_id INT references Event(id)

);

CREATE TABLE Categories (
	id serial primary key,
	name VARCHAR(50)
);


CREATE TABLE Reserve (
	id serial primary key,
	user_id INT references App_user(user_id).
	ven_id INT references Venue(id),
	cater_id INT references Catering_services(id),
	date_in date

)