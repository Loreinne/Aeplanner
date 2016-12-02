from flask import Flask
from app import views
import os

app = Flask(__name__)
app.debug = True


