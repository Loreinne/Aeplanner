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



@app.route('/api/v1.0/contract/', methods=['POST'])
#@auth.login_required
def new_contract():
    data = json.loads(request.data)
    res = spcall('new_contract', (
        data['reference'],
        data['client_name'],
        data['termsOfAgreement']))

    # if 'Error' in str(res[0][0]):
    #     return jsonify({'status': 'error', 'message': res[0][0]})
    return jsonify({'status': 'OK', 'message': res[0][0]}), 200



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
    