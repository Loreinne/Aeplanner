from flask import Flask
import os
from app import views
app = Flask(__name__)
app.debug = True


