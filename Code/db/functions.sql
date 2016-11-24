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