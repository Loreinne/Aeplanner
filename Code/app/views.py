from flask import Flask, jsonify
from flask.ext.httpauth import HTTPBasicAuth
from models import DBconn
import flask
import sys
import json

app = Flask(__name__)
auth = HTTPBasicAuth()

def spcall(qry, param, commit=False):
    try:
        dbo = DBconn()
        cursor = dbo.getcursor()
        cursor.callproc(qry, param)
        res = cursor.fetchall()
        if commit:
            dbo.dbcommit()
        return res
    except:
        res = [("Error: " + str(sys.exc_info()[0]) + " " + str(sys.exc_info()[1]),)]
    return res



@app.route('/contract', methods=['GET'])
@auth.login_required
def store_new_contract():
    data = json.loads(request.data)
    res = spcall('new_contract', (data))

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    recs = []
    for r in res:
        recs.append({"id": r[0], "reference": r[1], "client_name": r[2], "termsOfAgreement": str(r[3])})
    return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})



@app.route('/signup/', methods=['POST'])
def signup():

    jsn = json.loads(request.data)

    if invalid(jsn['email_address']):
        return jsonify({'status': 'error', 'message': 'Invalid Email address'})


    res = spcall('newuser', ( jsn['email_address'], jsn['first_name'], jsn['last_name'], jsn['password']))

    if 'Error' in str (res[0][0]):
        return jsonify ({'status': 'error', 'message': res[0][0]})

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