from flask import Flask, jsonify, request, session, redirect
from flask.ext.httpauth import HTTPBasicAuth
from models import DBconn, spcall
import flask, sys, json

app = Flask(__name__)

auth = HTTPBasicAuth()


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
def loginhoteladmin():
    data = request.json
    # if invalid(data['email_address']):
    #     status = False
    #     return jsonify({'status': status, 'message': 'Invalid Email address'})

    res = spcall("loginauth", (data['email_address'], data['password']))

    if res == 'ERROR':
        status = False
        return jsonify({'status': status, 'message': 'error'})
    else:
        status = True
        token = jwt.dumps({'user': data['email_address']})
        return jsonify({'status': status, 'token': token, 'hotel_id': res, 'message': 'success'})


@app.route('/api/v1.0/contract/', methods=['POST'])
#@auth.login_required
def store_contract():
    data = json.loads(request.data)
    res = spcall('new_contract', (
        data['reference'],
        data['client_name'],
        data['termsOfAgreement']), True)

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})
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
    reference = data['reference']
    client_name = data['client_name']
    termsOfAgreement = data['termsOfAgreement']
    
    res = spcall('update_contract', ( id,
                                     reference,
                                     client_name,
                                     termsOfAgreement), True)
    if 'Error' in str (res[0][0]):
        return jsonify ({'status': 'Error', 'message': res[0][0]})

    return jsonify({'status': 'OK', 'message': res[0][0]})



@app.route('/api/v1.0/proposal/', methods=['POST'])
def store_proposal():
    data = json.loads(request.data)
    res = spcall('new_proposal', (
          data['name'],
          data['address'],
          data['proposal_num'],
          data['proposal_name'],
          data['proposal_date']), True) 

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})
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




@app.route('/api/v1.0/signup/', methods=['POST'])
def signup():
    jsn = json.loads(request.data)

    if invalid(jsn['email_address']):
        return jsonify({'status': 'Error', 'message': 'Invalid Email address'})


    res = spcall('newuser', ( jsn['email_address'], jsn['first_name'], jsn['last_name'], jsn['password']))

    if 'Error' in str (res[0][0]):
        return jsonify ({'status': 'Error', 'message': res[0][0]})

    return jsonify({'status': 'OK', 'message': res[0][0]})



@app.route('/api/v1.0/user/<user_id>/', methods=['GET'])
def getspecificuser(user_id):
    res = spcall('getuser', [user_id])

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    rec = res[0]

    return jsonify({"email_address": str(rec[0]), "first_name": str(rec[1]), "last_name" : str(rec[2])})


@app.route('/api/v1.0/user/', methods = ['PUT'])
def update_user():
  jsn = json.loads(request.data)

  user_id = jsn.get('user_id', '')
  email_address = jsn.get('email_address', '')
  first_name = jsn.get('first_name', '')
  last_name = jsn.get('last_name', '')
  password = jsn.get('password', '')
  
  spcall('updateuser', (
    user_id,
    email_address,
    first_name,
    last_name,
    password), True)

  return jsonify({"status": "OK"})



@app.route('/api/v1.0/venue/', methods=['POST'])
def add_venue():
    jsn = json.loads(request.data)


    res = spcall('newvenue', ( jsn['V_name'], jsn['V_description'], jsn['V_categories'], jsn['V_location'], jsn['V_capacity'], jsn['V_pricing']))

    if 'Error' in str (res[0][0]):
        return jsonify ({'status': 'Error', 'message': res[0][0]})

    return jsonify({'status': 'OK', 'message': res[0][0]})


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
    