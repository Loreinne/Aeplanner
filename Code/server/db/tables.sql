CREATE TABLE App_user (
	user_id SERIAL PRIMARY KEY,
	image VARCHAR(50),
	email_address VARCHAR(50),
	fname VARCHAR(50),
	lname VARCHAR (50),
	password VARCHAR (50),
	address VARCHAR (50),
	birthdate date,
	age VARCHAR(5),
	is_active BOOLEAN DEFAULT TRUE
 );


CREATE TABLE Venue (
	v_id SERIAL PRIMARY KEY,
	v_image VARCHAR(50),
	v_name VARCHAR (50),
	v_email_address VARCHAR(50),
	v_description TEXT,
	v_location VARCHAR (50),
	v_capacity VARCHAR(50),
	v_pricing VARCHAR (50),
	v_categories TEXT,
	is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE Catering_services (
	c_id SERIAL PRIMARY KEY,
	c_image VARCHAR(50),
	c_name VARCHAR (50),
	c_email_address VARCHAR(50),
	c_description TEXT,
	c_location VARCHAR (50),
	c_pricing VARCHAR (50),
	c_categories TEXT,
	is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE Event (
	id serial primary key,
	user_id Int references App_user(user_id),
	title VARCHAR(50),
	date_event date,
	time_event time
);


CREATE TABLE Proposal (
	id		serial primary key,
	event_id Int references Event(id),
	name	VARCHAR(50),
	address VARCHAR(50),
	proposal_num VARCHAR(50),
	proposal_name text,
	proposal_date date
); 


CREATE TABLE Contract (
	id		serial primary key,
	event_id Int references Event(id),
	contract_reference	VARCHAR(50),
	client_name VARCHAR(50),
	termsOfAgreement text 
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
	client VARCHAR(50),
	about VARCHAR(50),
	app_date date,
	app_time time
);

CREATE TABLE Categories (
	id serial primary key,
	name VARCHAR(50)
);


CREATE TABLE Reserve (
	id serial primary key,
	user_id INT references App_user(user_id),
	ven_id INT references Venue(id),
	cater_id INT references Catering_services(id),
	date_in date

);