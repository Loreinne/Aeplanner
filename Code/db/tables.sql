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
	client_name text
);