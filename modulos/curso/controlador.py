import traceback
from flask import request, make_response
from modulos.empresa.business import BusinessEmpresa
from flask import Blueprint

from modulos.empresa.empresa import Empresa
from utils import GET, POST

ROTA_CURSO = '/curso'
app_curso = Blueprint('app_curso',
                      __name__,
                      url_prefix=ROTA_CURSO)

# business_empresa = BusinessEmpresa()
default_error = {'message': 'Não foi possível salvar uma empresa, contate o ADM'}


@app_curso.route('/', methods=[GET])
def get():
    return 'TESTE'
