from flask import Flask, request, jsonify, session, make_response, g
from flask_httpauth import HTTPTokenAuth
from itsdangerous import TimedJSONWebSignatureSerializer as JWT
import sys, os, flask, json
from models import DBconn, spcall
from flask.ext.cors import CORS, cross_origin
from flask.ext.bcrypt import Bcrypt
# from flaskext.mail import Mail
from paypalrestsdk import Payout, ResourceNotFound
import paypalrestsdk
import requests
import ssl
import logging
import urllib2
import time

app = Flask(__name__)

app.config['SECRET_KEY'] = 'EERwyDyEfWWO4NLFAqs8m4UZxKhZvMOsgeKqi1G0jgyREwE4LuZLC_g677uCJXcHUP7013FU65yAGoHM'

jwt = JWT(app.config['SECRET_KEY'], expires_in=3600)
auth = HTTPTokenAuth('Bearer')
CORS(app, supports_credentials=True)

@auth.verify_token
def verify_token(token):
    g.user = None
    try:
        data = jwt.loads(token)
    except:
        return False
    if 'user' in data:
        g.user = data['user']
        return True
    return False

GENERIC_DOMAINS = "aero", "asia", "biz", "cat", "com", "coop", \
                  "edu", "gov", "info", "int", "jobs", "mil", "mobi", "museum", \
                  "name", "net", "org", "pro", "tel", "travel"




def invalid(emailaddress, domains=GENERIC_DOMAINS):
    """Checks for a syntactically invalid email address."""

    # Email address must be 7 characters in total.
    if len(emailaddress) < 7:
        return True  # Address too short.

    # Split up email address into parts.
    try:
        localpart, domainname = emailaddress.rsplit('@', 1)
        host, toplevel = domainname.rsplit('.', 1)
    except ValueError:
        return True  # Address does not have enough parts.

    # Check for Country code or Generic Domain.
    if len(toplevel) != 2 and toplevel not in domains:
        return True  # Not a domain name.

    for i in '-_.%+.':
        localpart = localpart.replace(i, "")
    for i in '-_.':
        host = host.replace(i, "")

    if localpart.isalnum() and host.isalnum():
        return False  # Email address is fine.
    else:
        return True  # Email address has funny characters.


@app.route('/api/v1.0/login/', methods=['POST'])
def login():
    data = request.json

    res = spcall("loginauth", (data['email_address'], data['password']))

    if res == 'ERROR':
        status = False
        return jsonify({'status': status, 'message': 'error'})
    else:
        status = True
        token = jwt.dumps({'user': data['email_address']})
        return jsonify({'status': status, 'token': token, 'id': res, 'message': 'success'})


@app.route('/api/v1.0/contract/', methods=['POST'])
#@auth.login_required
def store_contract():
    data = json.loads(request.data)
    res = spcall('new_contract', (
        data['event_id'],
        data['contract_reference'],
        data['client_name'],
        data['termsOfAgreement']))

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'Error', 'message': res[0][0]})
    return jsonify({'status': 'OK', 'message': res[0][0]}), 200

@app.route('/api/v1.0/contract/<int:id>/', methods=['GET'])
def getcontract(id):
    res = spcall('show_contract', (id, ))
    recs = []
    if len(res) == 0:
        return jsonify({"status": "error", "message": "No entries found", "entries": []})
    elif 'Error' in str(res[0][0]):
        return jsonify({"status": "error", "message": res[0][0]})
    else:
        for r in res:
            recs.append({"id": r[0],
                         "reference": r[1],
                         "client_name": r[2],
                         "termsOfAgreement": r[3]})

            return jsonify({"status": "OK", "message": "OK", "entries": recs})
    

@app.route('/api/v1.0/contract/', methods=['PUT'])
def updatecontract():
    data = json.loads(request.data)
    id = data['id']
    contract_reference = data['contract_reference']
    client_name = data['client_name']
    termsOfAgreement = data['termsOfAgreement']
    
    res = spcall('update_contract', ( id,
                                     contract_reference,
                                     client_name,
                                     termsOfAgreement), True)
    if 'Error' in str (res[0][0]):
        return jsonify ({'status': 'Error', 'message': res[0][0]})

    return jsonify({'status': 'OK', 'message': res[0][0]})



@app.route('/api/v1.0/proposal/', methods=['POST'])
def store_proposal():
    jsn = json.loads(request.data)
    res = spcall('new_proposal', (
          jsn['event_id'],
          jsn['name'],
          jsn['address'],
          jsn['proposal_num'],
          jsn['proposal_name'],
          jsn['proposal_date']), True)

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'Error', 'message': res[0][0]})
    return jsonify({'status': 'OK', 'message': res[0][0]}), 200



@app.route('/api/v1.0/proposal/<int:id>/', methods=['GET'])
def getproposal(id):
    res = spcall('show_proposal', (id, ))
    recs = []
    if len(res) == 0:
        return jsonify({"status": "error", "message": "No entries found", "entries": []})
    elif 'Error' in str(res[0][0]):
        return jsonify({"status": "error", "message": res[0][0]})
    else:
        for r in res:
            recs.append({"id": r[0],
                         "name": r[1],
                         "address": r[2],
                         "propsal_num": str(r[3]),
                         "proposal_name": r[4],
                         "proposal_date": str(r[5])})

            return jsonify({"status": "OK", "message": "OK", "entries": recs})


@app.route('/api/v1.0/proposal/', methods=['PUT'])
def updateproposal():
    data = json.loads(request.data)
    id = data['id']
    name = data['name']
    address = data['address']
    proposal_num = data['proposal_num']
    proposal_name = data['proposal_name']
    proposal_date = data['proposal_date']

    
    res = spcall('update_proposal', ( id,
                                     name,
                                     address,
                                     proposal_num,
                                     proposal_name,
                                     proposal_date), True)
    if 'Error' in str (res[0][0]):
        return jsonify ({'status': 'Error', 'message': res[0][0]})

    return jsonify({'status': 'OK', 'message': res[0][0]})


@app.route('/api/v1.0/note/', methods=['POST'])
def store_note():
    jsn = json.loads(request.data)
    res = spcall('newnote', ( jsn['event_id'],
                              jsn['title'],
                              jsn['note']))

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'Error', 'message': res[0][0]})
    return jsonify({'status': 'OK', 'message': res[0][0]}), 200


@app.route('/api/v1.0/note/<int:n_id>/', methods=['GET'])
def getnote(n_id):
    res = spcall('show_note', (n_id, ))
    recs = []
    if len(res) == 0:
        return jsonify({"status": "error", "message": "No entries found", "entries": []})
    elif 'Error' in str(res[0][0]):
        return jsonify({"status": "error", "message": res[0][0]})
    else:
        for r in res:
            recs.append({"id": r[0],
                         "title": str(r[1]),
                         "note": r[2]})

            return jsonify({"status": "OK", "message": "OK", "entries": recs})


@app.route('/api/v1.0/note/', methods=['PUT'])
def updatenote():
    data = json.loads(request.data)
    id = data['id']
    title = data['title']
    note = data['note']
    
    res = spcall('updatenote', ( id,
                                title,
                                note), True)

    if 'Error' in str (res[0][0]):
        return jsonify ({'status': 'Error', 'message': res[0][0]})

    return jsonify({'status': 'OK', 'message': res[0][0]})
    

@app.route('/api/v1.0/appointment/', methods=['POST'])
def store_appointment():
    jsn = json.loads(request.data)
    res = spcall('newappointment', (jsn['event_id'],
                                      jsn['client'],
                                      jsn['about'],
                                      jsn['app_date'],
                                      jsn['app_time']))

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'Error', 'message': res[0][0]})
    return jsonify({'status': 'OK', 'message': res[0][0]}), 200



@app.route('/api/v1.0/appointment/<int:id>/', methods=['GET'])
def getappointment(id):
    res = spcall('show_appointment', (id, ))
    recs = []
    if len(res) == 0:
        return jsonify({"status": "error", "message": "No entries found", "entries": []})
    elif 'Error' in str(res[0][0]):
        return jsonify({"status": "error", "message": res[0][0]})
    else:
        for r in res:
            recs.append({"id": r[0],
                         "client": str(r[1]),
                         "about": str(r[2]),
                         "app_date": str(r[3]),
                         "app_time": str(r[4])})

            return jsonify({"status": "OK", "message": "OK", "entries": recs})


@app.route('/api/v1.0/appointment/', methods=['PUT'])
def updateappointment():
    jsn = json.loads(request.data)
    id = jsn['id']
    client = jsn['client']
    about = jsn['about']
    app_date = jsn['app_date']
    app_time = jsn['app_time']

    res = spcall('update_appointment', ( id,
                                         client,
                                         about,
                                         app_date,
                                         app_time), True)

    if 'Error' in str (res[0][0]):
        return jsonify ({'status': 'Error', 'message': res[0][0]})
    return jsonify({'status': 'OK', 'message': res[0][0]})
    


@app.route('/api/v1.0/signup/', methods=['POST'])
def signup():
    jsn = json.loads(request.data)

    if invalid(jsn['email_address']):
        return jsonify({'status': 'Error', 'message': 'Invalid Email address'})


    res = spcall('newuser', ( jsn['email_address'], jsn['fname'], jsn['lname'], jsn['password'], jsn['address'], jsn['birthdate'], jsn['age']))

    if 'Error' in str (res[0][0]):
        return jsonify ({'status': 'Error', 'message': res[0][0]})

    return jsonify({'status': 'OK', 'message': res[0][0]})



@app.route('/api/v1.0/user/<user_id>/', methods=['GET'])
def getspecificuser(user_id):
    res = spcall('getuser', [user_id])

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    rec = res[0]

    return jsonify({"email_address": str(rec[0]), "fname": str(rec[1]), "lname" : str(rec[2]), "address" :str(rec[3]), "birthdate" : str(rec[4]), "age" : str(rec[5])})


@app.route('/api/v1.0/user/', methods = ['PUT'])
def update_user():
  jsn = json.loads(request.data)

  user_id = jsn.get('user_id', '')
  email_address = jsn.get('email_address', '')
  fname = jsn.get('fname', '')
  lname = jsn.get('lname', '')
  password = jsn.get('password', '')
  address = jsn.get('address', '')
  birthdate = jsn.get('birthdate', '')
  age = jsn.get('age', '')
  
  spcall('updateuser', (
    user_id,
    email_address,
    fname,
    lname,
    password,
    address,
    birthdate,
    age), True)

  return jsonify({"status": "OK"})




@app.route('/api/v1.0/venue/', methods=['POST'])
def add_venue():
    jsn = json.loads(request.data)


    res = spcall('newvenue', ( jsn['v_name'], jsn['v_email_address'], jsn['v_description'], jsn['v_location'], jsn['v_capacity'], jsn['v_pricing'], jsn['v_categories']))

    if 'Error' in str (res[0][0]):
        return jsonify ({'status': 'Error', 'message': res[0][0]})

    return jsonify({'status': 'OK', 'message': res[0][0]})



@app.route('/api/v1.0/venue/', methods=['GET'])
def get_all_venue():
    res = spcall('showall_venues', ())

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    recs = []

    for r in res:
        recs.append(
            {"v_name": str(r[0]), "v_email_address": str(r[1]), "v_description": str(r[2]), "v_location": str(r[3]),
             "v_capacity": str(r[4]),"v_pricing": str(r[5]), "v_categories": str(r[6])})
    return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})

    if len(res) > 0:
        for r in res:
            recs.append({"v_name": str(r[0]), "v_email_address": str(r[1]), "v_description": str(r[2]), "v_location": str(r[3]),
             "v_capacity": str(r[4]),"v_pricing": str(r[5]), "v_categories": str(r[6])})
            return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})
    else:
        return jsonify({'status': 'no entries in database'})

@app.route('/api/v1.0/venue/<id>/', methods=['GET'])
def getspecificvenue(id):
    res = spcall('show_venue', [id])

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    rec = res[0]

    return jsonify({"v_name": str(rec[0]),  "v_email_address": str(rec[1]), "v_description" : str(rec[2]), "v_location" : str(rec[3]), "v_capacity": str(rec[4]), "v_pricing" : str(rec[5]), "v_categories" : str(rec[6])})

@app.route('/api/v1.0/venue/', methods = ['PUT'])
def update_venue():
  jsn = json.loads(request.data)

  v_id = jsn.get('v_id', '')
  v_name = jsn.get('v_name', '')
  v_email_address = jsn.get('v_email_address', '')
  v_description = jsn.get('v_description', '')
  v_location = jsn.get('v_location', '')
  v_capacity = jsn.get('v_capacity', '')
  v_pricing = jsn.get('v_pricing', '')
  v_categories = jsn.get('v_categories', '')


  spcall('updatevenue', (
    v_id,
    v_name,
    v_email_address,
    v_description,
    v_location,
    v_capacity,
    v_pricing,
    v_categories ), True)

  return jsonify({"status": "OK"})



@app.route('/api/v1.0/catering_services/', methods=['POST'])
def add_catering():
    jsn = json.loads(request.data)


    res = spcall('newcatering', ( jsn['c_name'], jsn['c_email_address'], jsn['c_description'], jsn['c_location'], jsn['c_pricing'], jsn['c_categories']))

    if 'Error' in str (res[0][0]):
        return jsonify ({'status': 'Error', 'message': res[0][0]})

    return jsonify({'status': 'OK', 'message': res[0][0]})



@app.route('/api/v1.0/catering_services/', methods=['GET'])
def get_all_catering_services():
    res = spcall('showall_cater', ())

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    recs = []

    for r in res:
        recs.append(
            {"c_name": str(r[0]), "c_email_address": str(r[1]), "c_description": str(r[2]), "c_location": str(r[3]),
             "c_pricing": str(r[4]),"c_categories": str(r[5])})

    return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})

    if len(res) > 0:
        for r in res:
            recs.append({"c_name": str(r[0]), "c_email_address": str(r[1]), "c_description": str(r[2]), "c_location": str(r[3]),
             "c_pricing": str(r[4]),"c_categories": str(r[5])})
            return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})
    else:
        return jsonify({'status': 'no entries in database'})



@app.route('/api/v1.0/catering_services/<id>/', methods=['GET'])
def getspecificcater(id):
    res = spcall('show_cater', [id])

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    rec = res[0]

    return jsonify({"c_name": str(rec[0]),  "c_email_address": str(rec[1]), "c_description" : str(rec[2]), "c_location" : str(rec[3]), "c_pricing" : str(rec[4]), "c_categories" : str(rec[5])})



@app.route('/api/v1.0/catering_services/', methods = ['PUT'])
def update_catering():
  jsn = json.loads(request.data)

  c_id = jsn.get('c_id', '')
  c_name = jsn.get('c_name', '')
  c_email_address = jsn.get('c_email_address', '')
  c_description = jsn.get('c_description', '')
  c_location = jsn.get('c_location', '')
  c_pricing = jsn.get('c_pricing', '')
  c_categories = jsn.get('c_categories', '')


  spcall('updatecater', (
    c_id,
    c_name,
    c_email_address,
    c_description,
    c_location,
    c_pricing,
    c_categories ), True)

  return jsonify({"status": "OK"})



@app.route('/api/v1.0/events/', methods=['POST'])
def add_event():
    jsn = json.loads(request.data)


    res = spcall('newevent', ( jsn['user_id'], jsn['title'], jsn['date_event'], jsn['time_event']))

    if 'Error' in str (res[0][0]):
        return jsonify ({'status': 'Error', 'message': res[0][0]})

    return jsonify({'status': 'OK', 'message': res[0][0]})



@app.route('/api/v1.0/events/<id>/', methods=['GET'])
def get_event(id):
    res = spcall('get_event', [id])

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    rec = res[0]

    return jsonify({"title": str(rec[0]),  "date_event": str(rec[1]), "time_event" : str(rec[2])})


@app.route('/api/v1.0/events/', methods = ['PUT'])
def update_event():
  jsn = json.loads(request.data)

  id = jsn.get('id', '')
  title = jsn.get('title', '')
  date_event = jsn.get('date_event', '')
  time_event = jsn.get('time_event', '')


  spcall('updatecater', (
    id,
    title,
    date_event,
    time_event), True)

  return jsonify({"status": "OK"})

  

@app.after_request
def add_cors(resp):
    resp.headers['Access-Control-Allow-Origin'] = flask.request.headers.get('Origin', '*')
    resp.headers['Access-Control-Allow-Credentials'] = True
    resp.headers['Access-Control-Allow-Methods'] = 'POST, OPTIONS, GET, PUT, DELETE'
    resp.headers['Access-Control-Allow-Headers'] = flask.request.headers.get('Access-Control-Request-Headers',
                                                                             'Authorization')
    # set low for debugging

    if app.debug:
        resp.headers["Access-Control-Max-Age"] = '1'
    return resp

if __name__ == '__main__':
    app.run(debug=True)
    