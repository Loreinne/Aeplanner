
create or replace function new_proposal(in par_id int, in par_name text, in par_address text, in par_proposal_num int, in par_proposal_name text, in par_proposal_date date) returns text par_address
$$
declare local_response text;
	begin
		insert into Proposal(id, name, address, proposal_num, proposal_name, proposal_date)
		values (par_id, par_name, par_address, par_proposal_num, par_proposal_name, par_proposal_date);
		local_response = 'OK';
		return local_response;
	end;

$$
language 'plpgsql';


create or replace function show_proposal(in par_id int, out text, out text, out int, out text, out date) returns setof record AS
$$
  SELECT *
  from Proposal
  WHERE id = par_id;
$$
  language 'sql';


create or replace function update_proposal(in par_id int, in par_name text, in par_address text, in par_proposal_num int, in par_proposal_name text, in par_proposal_date date) returns text AS
$$
  local_response text;
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



create or replace function new_contract(in par_id int, in par_reference text, in par_client_name text, in par_termsOfAgreement text) returns text AS
$$
  local_response text;
    begin
      insert into Contract(id, reference, client_name, termsOfAgreement)
      values (par_id, par_reference, par_client_name, par_termsOfAgreement);
      local_response = 'OK';
      return local_response;
    end;

$$
language 'plpgsql';


create or replace function show_contract(in par_id, out reference, out client_name, out termsOfAgreement) returns setof record AS
$$
  SELECT *
  from Contract
  WHERE id = par_id;
$$
  language 'sql';


create or replace function newuser(par_email VARCHAR,par_firstname VARCHAR, par_lastname VARCHAR, par_password VARCHAR) returns TEXT AS
$$
   DECLARE
        loc_email VARCHAR;
        loc_res TEXT;
    BEGIN
      SELECT INTO loc_email par_email FROM User WHERE email_address = par_email;
        if loc_email isnull THEN

      if par_email = '' or par_firstname = '' or par_lastname = ''  or par_password = '' THEN
        loc_res = 'Error';

      ELSE
          INSERT INTO User (email_address, first_name, last_name, password)
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
          INSERT INTO Venue (V_name, V_description, V_categories, V_location, V_capacity, V_)
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

