from lettuce import step, world, before
from nose.tools import assert_equals
from webtest import *
from app import app
from app.views import *
import json


@before.all
def before_all():
    world.app = app.test_client()

@step(u'Given the following information')
def given_the_following_information(step):
    world.info = step.hashes[0]

@step(u'When I click the add contract button')
def when_i_click_the_add_button(step):
    world.browser = TestApp(app)
    world.response = world.app.post('/api/v1.0/contract/', data = json.dumps(world.info))

@step(u'Then i will get a \'([^\']*)\' response')
def then_it_should_have_a_group1_response(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))


@step(u'And it should have a field \'([^\']*)\' containing \'([^\']*)\'')
def and_it_should_have_a_field_group1_containing_group2(step, field, expected_value):
    world.response_json = json.loads(world.response.data)
    assert_equals(str(world.response_json[field]), expected_value)

@step(u'Given a contract \'([^\']*)\' is in the system')
def given_a_contract_group1_is_in_the_system(step, id):
    world.contract = world.app.get('/api/v1.0/contract/{}/'.format(id))
    world.res = json.loads(world.contract.data)
    assert_equals(world.res['status'], 'OK')  

@step(u'When I retrieve the contract \'([^\']*)\'')
def when_i_retrive_the_contract_group1(step, id):
    world.response = world.app.get('/api/v1.0/contract/{}/'.format(id))  

@step(u'And the following contract details are returned:')
def and_the_following_contract_details_are_returned(step):
    res = json.loads(world.response.data)
    assert_equals(world.res['entries'], res['entries'])


@step(u'Given a contract id \'([^\']*)\' is in the system with the following information:')
def given_a_contract_id_group1_is_in_the_system_with_the_following_information(step, group1):
    world.contract_oldInfo = step.hashes[0]

@step(u'And the new contract information for contract id \'([^\']*)\'')
def and_the_new_contract_information_for_contract_id_group1(step, group1):
    world.contract_updateInfo = step.hashes[0]

@step(u'When I click the update contract button')
def when_i_click_the_update_contract_button(step):
    world.response = world.app.put('/api/v1.0/contract/', data = json.dumps(world.contract_updateInfo))
    
@step(u'When I click the add note button')
def when_i_click_the_add_note_button(step):
    world.response = world.app.post('/api/v1.0/note/', data = json.dumps(world.info))


@step(u'Given a note id \'([^\']*)\' is in the system')
def given_a_note_id_group1_is_in_the_system(step, id):
    world.note = world.app.get('/api/v1.0/note/{}/'.format(id))
    world.res = json.loads(world.note.data)
   
@step(u'When I retrieve the note id \'([^\']*)\'')
def when_i_retrieve_the_note_id_group1(step, id):
    world.response = world.app.get('/api/v1.0/note/{}/'.format(id))

@step(u'And the following note details are returned:')
def and_the_following_note_details_are_returned(step):
    res = json.loads(world.response.data)
    assert_equals(world.res['entries'], res['entries'])


@step(u'Given a note \'([^\']*)\' is in the system with the following details:')
def given_a_note_group1_is_in_the_system_with_the_following_details(step, group1):
    world.note_oldInfo = step.hashes[0]

@step(u'And the new note information for note id \'([^\']*)\'')
def and_the_new_note_information_for_note_id_group1(step, group1):
    world.note_updateInfo = step.hashes[0]

@step(u'When I click the update note button')
def when_i_click_the_update_note_button(step):
    world.response = world.app.put('/api/v1.0/note/', data = json.dumps(world.note_updateInfo))

@step(u'When I click the add proposal button')
def when_i_click_the_add_proposal_button(step):
    world.response = world.app.post('/api/v1.0/proposal/', data = json.dumps(world.info))

@step(u'Given a proposal id \'([^\']*)\' is in the system')
def given_a_proposal_id_group1_is_in_the_system(step, id):
    world.proposal = world.app.get('/api/v1.0/proposal/{}/'.format(id))
    world.res = json.loads(world.proposal.data)
   
@step(u'When I retrieve the proposal \'([^\']*)\'')
def when_i_retrieve_the_proposal_group1(step, id):
    world.response = world.app.get('/api/v1.0/proposal/{}/'.format(id))

@step(u'And the following proposal details are returned:')
def and_the_following_proposal_details_are_returned(step):
    res = json.loads(world.response.data)
    assert_equals(world.res['entries'], res['entries'])

@step(u'Given a proposal \'([^\']*)\' is in the system with the following details:')
def given_a_proposal_group1_is_in_the_system_with_the_following_details(step, group1):
    world.proposal_oldInfo = step.hashes[0]

@step(u'And the new proposal information for proposal id \'([^\']*)\'')
def and_the_new_proposal_information_for_proposal_id_group1(step, group1):
    world.proposal_updateInfo = step.hashes[0]

@step(u'When I click the update proposal button')
def when_i_click_the_update_proposal_button(step):
    world.response = world.app.put('/api/v1.0/proposal/', data = json.dumps(world.proposal_updateInfo))

@step(u'When I click the add appointment button')
def when_i_click_the_add_appointment_button(step):
    world.response = world.app.post('/api/v1.0/appointment/', data = json.dumps(world.info))

@step(u'Given a appointment id \'([^\']*)\' is in the system')
def given_a_appointment_id_group1_is_in_the_system(step, id):
    world.appointment = world.app.get('/api/v1.0/appointment/{}/'.format(id))
    world.res = json.loads(world.appointment.data)

@step(u'When I retrieve the appointment \'([^\']*)\'')
def when_i_retrieve_the_appointment_group1(step, id):
    world.response = world.app.get('/api/v1.0/appointment/{}/'.format(id))

@step(u'And the following appointment details are returned:')
def and_the_following_appointment_details_are_returned(step):
    res = json.loads(world.response.data)
    assert_equals(world.res['entries'], res['entries'])

@step(u'Given a appointment \'([^\']*)\' is in the system with the following details:')
def given_a_appointment_group1_is_in_the_system_with_the_following_details(step, group1):
    world.appointment_oldInfo = step.hashes[0]

@step(u'And the new appointment information for appointment id \'([^\']*)\'')
def and_the_new_appointment_information_for_appointment_id_group1(step, group1):
    world.appointment_updateInfo = step.hashes[0]

@step(u'When I click the update appointment button')
def when_i_click_the_update_appointment_button(step):
    world.response = world.app.put('/api/v1.0/appointment/', data = json.dumps(world.appointment_updateInfo))





@step(u'When i submit the signup form')
def signup_form(step):
	world.uri = '/api/v1.0/signup/'
	world.response = world.app.post(world.uri, data = json.dumps(world.info))


@step(u'Given a user with id \'(.*)\'')
def given_some_rooms_are_in_the_system(step,id):
    world.user = world.app.get('/api/v1.0/user/{}/'.format(id))

@step(u'When i retrieve a user with id \'(.*)\'')
def when_i_retrieve_the_room_number(step,id):
    world.response = world.app.get('/api/v1.0/user/{}/'.format(id))


@step(u'And the following details are returned:')
def details_returned(step):
    world.info = step.hashes[0]
    assert_equals(world.info, json.loads(world.response.data))



@step(u'Given a user with id no. \'(.*)\' exist')
def given_a_user_exist(step,id):
    world.user = world.app.get('/api/v1.0/user/{}/'.format(id))

@step(u'When I update the user details into the following:')
def userupdate(step):
    world.details = step.hashes[0]
    world.url = '/api/v1.0/user/'
    world.response = world.app.put(world.url, data = json.dumps(world.details))


@step(u'When I click the add button')
def addvenue(step):
     world.response = world.app.post('/api/v1.0/venue/', data = json.dumps(world.info))


@step(u'When I update the venue details into the following:')
def updatevenue(step):
    world.v = step.hashes[0]
    world.response = world.app.put('/api/v1.0/venue/', data = json.dumps(world.v))


@step(u'Given that a venue with id no. \'(.*)\' exist')
def given_a_venue_exist(step, id):
    world.response = world.app.get('/api/v1.0/venue/{}/'.format(id))
    
@step(u'When I retrieve a venue with id no. \'(.*)\'')
def retrieve_venue(step,id):
    world.res = json.loads(world.response.data)


@step(u'When i click the login button')
def login_user(step):
    world.response = world.app.post('/api/v1.0/login/',data = json.dumps(world.info))




@step(u'When I click the add catering services')
def addcater(step):
    world.response = world.app.post('/api/v1.0/catering_services/', data = json.dumps(world.info))


@step(u'Given that a catering service with id no. \'(.*)\' exist')
def given_cater_exist(step,id):
    world.response = world.app.get('/api/v1.0/catering_services/{}/'.format(id))

@step(u'When I retrieve a catering service with id no. \'(.*)\'')
def retrieve_cater(step,id):
    world.res = json.loads(world.response.data)

@step('When I update the catering service details into the following:')
def update_cater(step):
    world.u = step.hashes[0]
    world.response = world.app.put('/api/v1.0/catering_services/', data = json.dumps(world.u))



@step('When I add the event')
def addevent(step):
    world.response= world.app.post('/api/v1.0/events/', data = json.dumps(world.info))


@step(u'Given that an event with id no. \'(.*)\' exist')
def getevent(step,id):
    world.response = world.app.get('/api/v1.0/events/{}/'.format(id))

@step(u'When I retrieve the event with id \'(.*)\'')
def retrieve_venue(step,id):
    world.res = json.loads(world.response.data)


@step('When I update event details with the following:')
def updateevent(step):
    world.u = step.hashes[0]
    world.response = world.app.put('/api/v1.0/events/', data=json.dumps(world.u))