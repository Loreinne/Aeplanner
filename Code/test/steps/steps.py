from lettuce import step, world, before
from nose.tools import assert_equals
from webtest import *
from app import app
import json


@before.all
def before_all():
    world.app = app.test_client()

""" Common steps for jsonify response """

@step(u'Given the following information')
def given_the_following_information(step):
    world.contract = step.hashes[0]

@step(u'When I click the contract button')
def when_i_click_the_contract_button(step):
   world.response = world.app.post('/contract', data = json.dumps(world.contract))

@step(u'Then  it should have a \'([^\']*)\' response')
def then_it_should_have_a_group1_response(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))


@step(u'And   it should have a field \'([^\']*)\' containing \'([^\']*)\'')
def and_it_should_have_a_field_group1_containing_group2(step, field, expected_value):
    world.response_json = json.loads(world.response.data)
    assert_equals(str(world.response_json[field]), expected_value)

