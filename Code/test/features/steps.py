from lettuce import step, world, before
from nose.tools import assert_equals
from webtest import *
from app import app
from app.views import *
import json


@before.all
def before_all():
    world.app = app.test_client()

""" Common steps for jsonify response """

@step(u'Given the following information')
def given_the_following_information(step):
    world.info = step.hashes[0]

@step(u'When I click the contract button')
def when_i_click_the_contract_button(step):
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
