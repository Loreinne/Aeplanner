CREATE TABLE App_user (
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
);

CREATE TABLE Proposal (
	id		serial primary key,
	event_id Int references Event(id),
	name	VARCHAR(50),
	address VARCHAR(50),
	proposal_num VARCHAR(50),
	proposal_name VARCHAR(50),
	proposal_date date
);

CREATE TABLE Contract (
	id		serial primary key,
	event_id Int references Contract(id),
	contract_reference	VARCHAR(50),
	client_name VARCHAR(50),
	termsOfAgreement text 
);


CREATE TABLE Event (
	id serial primary key,
	user_id Int references App_user(user_id),
	title VARCHAR(50),
	date_event date,
	time_event time
);

CREATE TABLE Note (
	id  serial primary key,
	event_id Int references Event(id),
	title VARCHAR (50),
	note Text
);

CREATE TABLE Appointment (
	id serial primary key,
	event_id Int references Event(id),
	title VARCHAR(50),
	appointment_date date,
	appointment_time time
);