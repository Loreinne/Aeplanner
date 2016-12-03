-- PROPOSAL



create or replace function show_proposalAll(out par_id int, out text, out text, out int, out text, out date) returns setof record AS
$$
  SELECT id, name, address, proposal_num, proposal_name, proposal_date
  from Proposal;
 
$$
  language 'sql';


create or replace function show_proposal(in par_id int, out int, out text, out text, out varchar, out text, out date) returns setof record AS
$$
  SELECT id, name, address, proposal_num, proposal_name, proposal_date
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

create or replace function new_proposal(in par_name text, in par_address text, in par_proposal_num VARCHAR, in par_proposal_name text, in par_proposal_date date) returns text AS
$$
  declare 
  local_response text;
  local_name text;
  begin
    SELECT into local_name par_name FROM Proposal WHERE name = par_name;
      if local_name isnull THEN
    if par_name = '' or par_address = '' or par_proposal_num = '' or par_proposal_name = '' or par_proposal_date = isnull THEN
      local_response = 'Error';
    ELSE
    insert into Proposal(name, address, proposal_num, proposal_name, proposal_date)
    values (par_name, par_address, par_proposal_num, par_proposal_name, par_proposal_date);
      local_response = 'OK';
    end if;
    ELSE
    local_response ='proposal exists';
    end if;
    return local_response;
  end;

$$
language 'plpgsql';

-- CONTRACT
create or replace function new_contract(in par_reference text, in par_client_name text, in par_termsOfAgreement text) returns text AS
$$
  declare 
  local_response text;
  local_client_name text;
    begin
      SELECT into local_client_name par_client_name from Contract WHERE client_name = par_client_name;
        if local_client_name isnull THEN
      if par_reference = '' or par_client_name = '' or par_termsOfAgreement = '' THEN
        local_response = 'Error';
      ELSE
      insert into Contract(reference, client_name, termsOfAgreement)
      values (par_reference, par_client_name, par_termsOfAgreement);
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
  SELECT id, reference, client_name, termsOfAgreement
  from Contract
  WHERE id = par_id;
$$
  language 'sql';



create or replace function update_contract(in par_id int, in par_reference text, in par_client_name text, par_termsOfAgreement text) returns text AS
$$
  declare local_response text;
    begin
      UPDATE Contract
      set
        id = par_id,
        reference = par_reference,
        client_name = par_client_name,
        termsOfAgreement = par_termsOfAgreement
      WHERE id = par_id;

      local_response = 'OK';
      return local_response;
    end;

$$
  language 'plpgsql';


-- USER

create or replace function newuser(par_email VARCHAR,par_firstname VARCHAR, par_lastname VARCHAR, par_password VARCHAR) returns TEXT AS
$$
   DECLARE
        loc_email VARCHAR;
        loc_res TEXT;
    BEGIN
      SELECT INTO loc_email par_email FROM App_user WHERE email_address = par_email;
        if loc_email isnull THEN

      if par_email = '' or par_firstname = '' or par_lastname = ''  or par_password = '' THEN
        loc_res = 'Error';

      ELSE
          INSERT INTO App_user (email_address, first_name, last_name, password)
                        VALUES (par_email, par_firstname, par_lastname, par_password);
                        loc_res = 'OK';
          end if;

        ELSE
          loc_res = 'Error';

        end if;
        return loc_res;

    END;
$$
    LANGUAGE 'plpgsql';

-- select newuser('eloreinne@gmail.com', 'Loreinne', 'Estenzo', 'lala');


create or replace function getuser(IN par_id int, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR) RETURNS SETOF RECORD AS
$$
  SELECT email_address, first_name, last_name
  FROM App_user
  WHERE user_id = par_id
$$
  LANGUAGE 'sql';

  
--VENUE

create or replace function newvenue(par_name VARCHAR,par_description TEXT, par_categories VARCHAR, par_location VARCHAR,  par_capacity VARCHAR,  par_pricing VARCHAR) returns TEXT AS
$$
   DECLARE
        loc_name VARCHAR;
        loc_res TEXT;
    BEGIN
      SELECT INTO loc_name par_name FROM Venue WHERE name = par_name;
        if loc_email isnull THEN

      if par_name = '' or par_description = '' or par_categories = ''  or par_location = '' or par_capacity = '' or par_pricing = '' THEN
        loc_res = 'Error';

      ELSE
          INSERT INTO Venue (V_name, V_description, V_categories, V_location, V_capacity, V_pricing)
                        VALUES (par_name, par_description, par_categories, par_location, par_capacity, par_pricing);
                        loc_res = 'OK';
          end if;

        ELSE
          loc_res = 'Error';

        end if;
        return loc_res;

    END;
$$
    LANGUAGE 'plpgsql';



create or replace function showall_venues (OUT VARCHAR, OUT TEXT, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR) returns setof record as
  $$

    SELECT V_name, V_description, V_categories, V_location, V_capacity, V_pricing FROM Venue ;

  $$

    LANGUAGE 'sql';



create or replace function show_venue (IN par_id int ,OUT VARCHAR, OUT TEXT, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR) returns setof record as
  $$

    SELECT V_name, V_description, V_categories, V_location, V_capacity, V_pricing FROM Venue WHERE  V_id = par_id ;

  $$

    LANGUAGE 'sql';

    


create or replace function updatevenue(par_id int, par_name VARCHAR,par_description TEXT, par_categories VARCHAR, par_location VARCHAR,  par_capacity VARCHAR,  par_pricing VARCHAR) returns void AS
  $$ 
    UPDATE Venue
    SET

    V_name = par_name,
    V_description = par_description,
    V_categories = par_categories,
    V_location = par_location,
    V_capacity = par_description,
    V_pricing = par_pricing

    WHERE V_id = par_id;
$$
    LANGUAGE 'sql';


-- CATERING

create or replace function newcatering(par_name VARCHAR,par_description TEXT, par_categories VARCHAR, par_location VARCHAR,  par_capacity VARCHAR,  par_pricing VARCHAR) returns TEXT AS
$$
   DECLARE
        loc_name VARCHAR;
        loc_res TEXT;
    BEGIN
      SELECT INTO loc_name par_name FROM Catering_services WHERE name = par_name;
        if loc_email isnull THEN

      if par_name = '' or par_description = '' or par_categories = ''  or par_location = '' or par_capacity = '' or par_pricing = '' THEN
        loc_res = 'Error';

      ELSE
          INSERT INTO Venue (c_name, c_description, c_categories, c_location, c_capacity, c_pricing)
                        VALUES (par_name, par_description, par_categories, par_location, par_capacity, par_pricing);
                        loc_res = 'OK';
          end if;

        ELSE
          loc_res = 'Error';

        end if;
        return loc_res;

    END;
$$
    LANGUAGE 'plpgsql';



create or replace function showall_cater (OUT VARCHAR, OUT TEXT, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR) returns setof record as
  $$

    SELECT c_name, c_description, c_categories, c_location, c_capacity, c_pricing FROM Catering_services ;

  $$

    LANGUAGE 'sql';



create or replace function show_cater (IN par_id int ,OUT VARCHAR, OUT TEXT, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR) returns setof record as
  $$

    SELECT c_name, c_description, c_categories, c_location, c_capacity, c_pricing FROM Catering_services WHERE  c_id = par_id ;

  $$

    LANGUAGE 'sql';



create or replace function updatecater(in par_id INT, par_name VARCHAR,par_description TEXT, par_categories VARCHAR, par_location VARCHAR,  par_capacity VARCHAR,  par_pricing VARCHAR) returns void AS
  $$ 
    UPDATE Catering_services
    SET

    c_name = par_name,
    c_description = par_description,
    c_categories = par_categories,
    c_location = par_location,
    c_capacity = par_description,
    c_pricing = par_pricing

    WHERE c_id = par_id;
$$
    LANGUAGE 'sql';




-- NOTE

create or replace function newnote (par_title VARCHAR, par_note TEXT) returns TEXT AS
  $$ 
    DECLARE
      loc_title VARCHAR;
      loc_res TEXT;
    BEGIN
      SELECT INTO loc_title par_title FROM Note WHERE n_title = par_title;
        if loc_title isnull THEN

      if par_title = '' or par_description = '' THEN
        loc_res = 'Error';

      ELSE
          INSERT INTO Note(n_title , n_note) VALUES (par_title, par_note);
                      loc_res = 'OK';

          end if;

        ELSE
          loc_res = 'Error';

        end if;
        return loc_res;

    END;
$$

  LANGUAGE 'plpgsql';


create or replace function show_note (IN par_id int ,OUT VARCHAR, OUT TEXT) returns setof record as
  $$

    SELECT n_title , n_note FROM Note WHERE  n_id = par_id ;

  $$

    LANGUAGE 'sql';


create or replace function showall_note (OUT VARCHAR, OUT TEXT) returns setof record as
  $$

  SELECT n_title, n_note FROM Note;

  $$

  LANGUAGE 'sql';


create or replace function updatenote(par_id int, par_title VARCHAR, par_note text) returns void AS
    $$
      UPDATE Note
      SET 
        n_title = par_title,
        n_note = par_note

      WHERE n_id = par_id;

$$

    LANGUAGE 'sql';
