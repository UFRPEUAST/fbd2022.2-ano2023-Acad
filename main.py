import re

from flask import Flask, request, Response, make_response

from modulos.curso.controlador import app_curso
from modulos.empresa.controlador import app_empresa, ROTA_EMPRESA

app = Flask(__name__)
app.register_blueprint(app_empresa)
app.register_blueprint(app_curso)


@app.route('/', methods=['GET'])
def home():
    return {}


app.run(debug=True,host='0.0.0.0')
