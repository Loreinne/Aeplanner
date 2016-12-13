-- PROPOSAL
create or replace function new_proposal(in par_event_id int, in par_name varchar, in par_address varchar, in par_proposal_num VARCHAR, in par_proposal_name varchar, in par_proposal_date date) returns text AS
$$
  declare 
  local_response text;
  local_name text;
  begin
    SELECT into local_name par_name FROM Proposal WHERE name = par_name;
      if local_name isnull THEN
    if par_name = '' or par_address = '' or par_proposal_num = '' or par_proposal_name = '' or par_proposal_date isnull THEN
      local_response = 'Error';
    ELSE
    insert into Proposal(event_id,name, address, proposal_num, proposal_name, proposal_date)
    values (par_event_id, par_name, par_address, par_proposal_num, par_proposal_name, par_proposal_date);
             local_response = 'OK';
    end if;
    ELSE
    local_response = 'proposal exists';
    end if;
    return local_response;
  end;

$$
language 'plpgsql';



create or replace function show_proposalAll(out par_id int, out text, out text, out int, out text, out date) returns setof record AS
$$
  SELECT id, name, address, proposal_num, proposal_name, proposal_date
  from Proposal;
 
$$
  language 'sql';


create or replace function show_proposal(in par_event_id, in par_id int, out int, out text, out text, out varchar, out text, out date) returns setof record AS
$$
  SELECT event_id, id, name, address, proposal_num, proposal_name, proposal_date
  from Proposal
  WHERE id = par_id;
$$
  language 'sql';


create or replace function update_proposal(in par_id int, in par_name text, in par_address text, in par_proposal_num int, in par_proposal_name text, in par_proposal_date date) returns text AS
$$
  declare local_response text;
    begin 
      UPDATE Proposal
      set
        name = par_name,
        address = par_address,
        proposal_num = par_proposal_num,
        proposal_name = par_proposal_name,
        proposal_date = par_proposal_date
      WHERE id = par_id;

      local_response = 'OK';
      return local_response;
    end;
$$
  language 'plpgsql';


-- CONTRACT
create or replace function new_contract(par_event_id int, par_contract_reference text, par_client_name text, par_termsOfAgreement text) returns text AS
$$
  declare 
  local_response text;
  local_client_name text;
    begin
      SELECT into local_client_name par_client_name from Contract WHERE client_name = par_client_name;
        if local_client_name isnull THEN
      if par_contract_reference = '' or par_client_name = '' or par_termsOfAgreement = '' THEN
        local_response = 'Error';
      ELSE
      insert into Contract(event_id, contract_reference, client_name, termsOfAgreement)
      values (par_event_id, par_contract_reference, par_client_name, par_termsOfAgreement);
          local_response = 'OK';
      end if;
      ELSE
      local_response = 'contract exists';
      END if;
      return local_response;
    end;

$$
language 'plpgsql';


create or replace function show_contractAll(out int, out text, out text, out text) returns setof record AS
$$
  SELECT id, reference, client_name, termsOfAgreement 
  from Contract;
  
$$
  language 'sql';



create or replace function show_contract(in par_id int, out int, out text, out text, out text) returns setof record AS
$$
  SELECT id, contract_reference, client_name, termsOfAgreement
  from Contract
  WHERE id = par_id;
$$
  language 'sql';



create or replace function update_contract(in par_id int, in par_contract_reference text, in par_client_name text, par_termsOfAgreement text) returns text AS
$$
  declare local_response text;
    begin
      UPDATE Contract
      set
        id = par_id,
        contract_reference = par_contract_reference,
        client_name = par_client_name,
        termsOfAgreement = par_termsOfAgreement
      WHERE id = par_id;

      local_response = 'OK';
      return local_response;
    end;

$$
  language 'plpgsql';


-- USER

create or replace function newuser(par_email VARCHAR,par_fname VARCHAR, par_lname VARCHAR, par_password VARCHAR, par_address VARCHAR, par_birthdate date, par_age varchar) returns TEXT AS
$$
   DECLARE
        loc_email VARCHAR;
        loc_res TEXT;
    BEGIN
      SELECT INTO loc_email par_email FROM App_user WHERE email_address = par_email;
        if loc_email isnull THEN

      if par_email = '' or par_fname = '' or par_lname = ''  or par_password = '' or par_address = '' or par_age = '' THEN
        loc_res = 'Error';

      ELSE
          INSERT INTO App_user (email_address, fname, lname, password, address, birthdate, age, is_active)
                        VALUES (par_email, par_fname, par_lname, par_password, par_address, par_birthdate, par_age, TRUE);
                        loc_res = 'OK';
          end if;

        ELSE
          loc_res = 'Error';

        end if;
        return loc_res;

    END;
$$
    LANGUAGE 'plpgsql';

-- select newuser('eloreinne@gmail.com', 'Loreinne', 'Estenzo', 'lala', 'Lugait', '11/10/96', '20');
-- select newuser('emal@gmail.com', 'Leila', 'Reyes', 'hellopo', 'iligan' ,'10/10/96', '20');

create or replace function updateuser(par_id int, par_email VARCHAR,par_fname VARCHAR, par_lname VARCHAR,  par_password VARCHAR, par_address VARCHAR, par_birthdate date, par_age varchar) returns void AS
  $$ 
    UPDATE App_user
    SET

    email_address = par_email,
    fname = par_fname,
    lname = par_lname,
    password = par_password,
    address = par_address,
    birthdate = par_birthdate,
    age = par_age

    WHERE user_id = par_id;
$$
    LANGUAGE 'sql';


create or replace function loginauth(in par_email text, in par_password text) returns text as
$$
  DECLARE
    loc_email text;
    loc_password text;
    loc_res text;
  BEGIN
    select into loc_email email_address from App_user where email_address = par_email;
    select into loc_password password from App_user where password = par_password;

    if loc_email isnull or loc_password isnull or loc_email = '' or loc_password = '' then
      loc_res = 'Invalid Email or Password';
    else
      loc_res = 'Successfully Logged In';
    end if;
    return loc_res;

  END;
$$
  LANGUAGE 'plpgsql';



create or replace function getuser(IN par_id int, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR, OUT DATE, OUT VARCHAR) RETURNS SETOF RECORD AS
$$
  SELECT email_address, fname, lname, address, birthdate, age
  FROM App_user
  WHERE user_id = par_id
$$
  LANGUAGE 'sql';

  
--VENUE

create or replace function newvenue(par_name VARCHAR,par_email VARCHAR, par_description TEXT, par_location VARCHAR,  par_capacity VARCHAR,  par_pricing VARCHAR, par_categories INT) returns TEXT AS
$$
   DECLARE
        loc_email VARCHAR;
        loc_res TEXT;
    BEGIN
      SELECT INTO loc_email par_email FROM Venue WHERE email_address = par_email;
        if loc_email isnull THEN

      if par_email = '' or  par_name = '' or par_description = ''  or par_location = '' or par_capacity = '' or par_pricing = '' or par_email = '' THEN
        loc_res = 'Error';

      ELSE
          INSERT INTO Venue (name, email_address, description, location, capacity, pricing, cat_id)
                        VALUES (par_name, par_email, par_description, par_location, par_capacity, par_pricing, par_categories);
                        loc_res = 'OK';
          end if;

        ELSE
          loc_res = 'Error';

        end if;
        return loc_res;

    END;
$$
    LANGUAGE 'plpgsql';



create or replace function showall_venues (OUT VARCHAR, OUT VARCHAR, OUT TEXT, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR,OUT INT) returns setof record as
  $$

    SELECT name, email_address, description, location, capacity, pricing, cat_id FROM Venue ;

  $$

    LANGUAGE 'sql';



create or replace function show_venue (IN par_id int ,OUT VARCHAR, OUT VARCHAR, OUT TEXT, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR, OUT INT) returns setof record as
  $$

    SELECT name, email_address, description, location, capacity, pricing, cat_id FROM Venue WHERE  id = par_id ;

  $$

    LANGUAGE 'sql';

    


create or replace function updatevenue(par_id int, par_name VARCHAR, par_email VARCHAR, par_description TEXT, par_location VARCHAR,  par_capacity VARCHAR,  par_pricing VARCHAR, par_categories INT) returns void AS
  $$ 
    UPDATE Venue
    SET

    name = par_name,
    email_address = par_email,
    description = par_description,
    location = par_location,
    capacity = par_description,
    pricing = par_pricing,
    cat_id = par_categories

    WHERE id = par_id;
$$
    LANGUAGE 'sql';


-- CATERING

create or replace function newcatering(par_name VARCHAR,par_email VARCHAR, par_description TEXT, par_location VARCHAR,  par_pricing VARCHAR, par_categories INT) returns TEXT AS
$$
   DECLARE
        loc_email VARCHAR;
        loc_res TEXT;
    BEGIN
      SELECT INTO loc_email par_email FROM Catering_services WHERE email_address = par_email;
        if loc_email isnull THEN

      if par_email = '' or  par_name = '' or par_description = ''  or par_location = '' or par_pricing = '' or par_email = '' THEN
        loc_res = 'Error';

      ELSE
          INSERT INTO Catering_services (name, email_address, description, location, pricing, cat_id)
                        VALUES (par_name, par_email, par_description, par_location,par_pricing, par_categories);
                        loc_res = 'OK';
          end if;

        ELSE
          loc_res = 'Error';

        end if;
        return loc_res;

    END;
$$
    LANGUAGE 'plpgsql';

create or replace function showall_cater (OUT VARCHAR, OUT VARCHAR, OUT TEXT, OUT VARCHAR, OUT VARCHAR, OUT INT) returns setof record as
  $$

    SELECT name, email_address, description, location, pricing, cat_id FROM Catering_services ;

  $$

    LANGUAGE 'sql';



create or replace function show_cater (IN par_id int ,OUT VARCHAR, OUT VARCHAR ,OUT TEXT, OUT VARCHAR, OUT VARCHAR, OUT INT) returns setof record as
  $$

    SELECT name, email_address, description, location, pricing, cat_id FROM Catering_services WHERE  id = par_id ;

  $$

    LANGUAGE 'sql';



create or replace function updatecater(in par_id INT, par_name VARCHAR, par_email VARCHAR, par_description TEXT, par_location VARCHAR,  par_pricing VARCHAR, par_categories INT) returns void AS
  $$ 
    UPDATE Catering_services
    SET

    name = par_name,
    email_address = par_email,
    description = par_description,
    location = par_location,
    pricing = par_pricing,
    cat_id = par_categories

    WHERE id = par_id;
$$
    LANGUAGE 'sql';




-- NOTE

create or replace function newnote (par_event_id int, par_title VARCHAR, par_note TEXT) returns TEXT AS
  $$ 
    DECLARE
      loc_title VARCHAR;
      loc_res TEXT;
    BEGIN
      SELECT INTO loc_title par_title FROM Note WHERE title = par_title;
        if loc_title isnull THEN

      if par_title = '' or par_note = '' THEN
        loc_res = 'Error';

      ELSE
          INSERT INTO Note(event_id, title , note) VALUES (par_event_id, par_title, par_note);
                      loc_res = 'OK';

          end if;

        ELSE
          loc_res = 'note already exist';

        end if;
        return loc_res;

    END;
$$

  LANGUAGE 'plpgsql';


create or replace function show_note (IN par_id int, OUT INT, OUT VARCHAR, OUT TEXT) returns setof record as
  $$

    SELECT id, title , note FROM Note WHERE  id = par_id ;

  $$

    LANGUAGE 'sql';


create or replace function showall_note (OUT VARCHAR, OUT TEXT) returns setof record as
  $$

  SELECT n_title, n_note FROM Note;

  $$

  LANGUAGE 'sql';


create or replace function updatenote(par_id int, par_title VARCHAR, par_note text) returns text AS
$$
  declare local_response text;
    begin
      UPDATE Note
      set
        id = par_id,
        title = par_title,
        note = par_note

      WHERE id = par_id;

      local_response = 'OK';
      return local_response;
    
    end;
$$

    LANGUAGE 'plpgsql';



--APPOINTMENT

create or replace function newappointment (par_event_id int, par_client Varchar, par_about VARCHAR, par_app_date date, par_app_time time) returns TEXT AS
  $$ 
    DECLARE
      local_client VARCHAR;
      loc_res TEXT;
    BEGIN
      SELECT INTO local_client par_client FROM Appointment WHERE client = par_client;
        if local_client isnull THEN

      if par_client = '' or par_about = '' or par_app_date isnull or par_app_time isnull THEN
        loc_res = 'Error';

      ELSE
          INSERT INTO Appointment(event_id, client, about, app_date, app_time) VALUES (par_event_id, par_client, par_about, par_app_date, par_app_time);
                      loc_res = 'OK';

          end if;

        ELSE
          loc_res = 'Appointment exist';

        end if;
        return loc_res;

    END;
$$

  LANGUAGE 'plpgsql';


create or replace function show_appointment (IN par_id int, out int, OUT VARCHAR, OUT varchar, out date, out time) returns setof record as
  $$

    SELECT id, client , about, app_date, app_time  FROM Appointment WHERE  id = par_id ;

  $$
    LANGUAGE 'sql';




-- Event

create or replace function newevent(par_user INT ,par_title VARCHAR, par_date DATE, par_time TIME) returns TEXT AS
$$
   DECLARE
        loc_title VARCHAR;
        loc_res TEXT;
    BEGIN
      SELECT INTO loc_title par_title FROM Event WHERE title = par_title;
        if loc_title isnull THEN

      if par_title = '' THEN
        loc_res = 'Error';

      ELSE
          INSERT INTO Event (user_id, title, date_event, time_event)
                        VALUES (par_user, par_title, par_date, par_time);
                        loc_res = 'OK';
          end if;

        ELSE
          loc_res = 'Error';

        end if;
        return loc_res;

    END;
$$
    LANGUAGE 'plpgsql';

create or replace function getevents(par_user INT, par_title VARCHAR, par_date DATE, par_time TIME) returns setof record as
  $$
  SELECT title, date_event, time_event FROM Event;
  $$

  LANGUAGE 'sql';



create or replace function get_event(IN par_id INT, OUT VARCHAR, OUT DATE, OUT TIME) returns setof record as
  $$
  SELECT title, date_event, time_event FROM Event WHERE id = par_id;
  $$

  LANGUAGE 'sql';
  


create or replace function update_event(par_id INT, par_title VARCHAR, par_date DATE, par_time TIME) returns void as
  $$
  UPDATE Event
  SET
    title = par_title,
    date_event = par_date,
    time_event = par_time

  WHERE id = par_id;
  $$

  LANGUAGE 'sql';
