from flask import Flask, jsonify, request, session, redirect
from flask.ext.httpauth import HTTPBasicAuth
from models import DBconn
import flask, json
import sys



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

@app.route('/api/v1.0/contract/', methods=['POST'])
@auth.login_required
def store_new_contract():
    data = json.loads(request.data)
    res = spcall('new_contract', (
        data['reference'],
        data['client_name'],
        data['termsOfAgreement']))

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})
    return jsonify({'status': 'OK', 'message': res[0][0]})



@app.route('api/v1.0/signup/', methods=['POST'])
def signup():

    jsn = json.loads(request.data)

    if invalid(jsn['email_address']):
        return jsonify({'status': 'error', 'message': 'Invalid Email address'})


    res = spcall('newuser', ( jsn['email_address'], jsn['first_name'], jsn['last_name'], jsn['password']))

    if 'Error' in str (res[0][0]):
        return jsonify ({'status': 'error', 'message': res[0][0]})

    return jsonify({'status': 'OK', 'message': res[0][0]})



@app.route('/api/v1.0/user/<user_id>/', methods=['GET'])
def gethotel(hotel_id):
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
    