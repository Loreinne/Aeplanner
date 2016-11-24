create or replace function new_proposal(int par_id int, in par_name text, in par_address text, in par_proposal_num int, in par_proposal_name text, in par_proposal_date date) returns text par_address
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


