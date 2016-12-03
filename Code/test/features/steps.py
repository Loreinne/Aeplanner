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


@step(u'Given the contract id \'([^\']*)\' is in the system with the following information:')
def given_the_contract_id_group1_is_in_the_system_with_the_following_information(step, group1):
    world.contract_oldInfo = step.hashes[0]

@step(u'And the new contract information for contract id \'([^\']*)\'')
def and_the_new_contract_information_for_contract_id_group1(step, group1):
    world.contract_updateInfo = step.hashes[0]

@step(u'When I click the update button')
def when_i_click_the_update_button(step):
    world.response = world.app.put('/api/v1.0/contract/', data = json.dumps(world.contract_updateInfo))
    

@step(u'When I click the add propsal button')
def when_i_click_the_add_propsal_button(step):
    world.response = world.app.post('/api/v1.0/proposal/', data = json.dumps(world.info))

@step(u'Given a proposal id \'([^\']*)\' is in the system')
def given_a_proposal_id_group1_is_in_the_system(step, group1):
    world.proposal = world.app.get('/api/v1.0/proposal/{}/'.format(id))
    world.res = json.loads(world.proposal.data)
    assert_equals(world.res['status'], 'OK') 

@step(u'When I retrieve the proposal \'([^\']*)\'')
def when_i_retrieve_the_proposal_group1(step, group1):
    world.proposal = world.app.get('/api/v1.0/proposal/{}/'.format(id))

@step(u'And the following proposal details are returned:')
def and_the_following_proposal_details_are_returned(step):
    res = json.loads(world.response.data)
    assert_equals(world.res['entries'], res['entries'])



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
