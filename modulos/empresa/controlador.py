import traceback
from flask import request, make_response
from modulos.empresa.business import BusinessEmpresa
from flask import Blueprint

from modulos.empresa.empresa import Empresa
from utils import GET, POST

ROTA_EMPRESA = '/empresa'
app_empresa = Blueprint('app_empresa',
                        __name__,
                        url_prefix=ROTA_EMPRESA)

business_empresa = BusinessEmpresa()
default_error = {'message': 'Não foi possível salvar uma empresa, contate o ADM'}


@app_empresa.route('/', methods=[GET, POST])
def get():
    try:
        if request.method == POST:
            data = request.get_json()
            error, msg = business_empresa.validar_campos(data, Empresa.CAMPOS_OBRIGATORIOS)
            if error:
                return make_response(msg, 404)
            empresa = business_empresa.salvar(data)
            if empresa:
                return make_response({"id": empresa.id}, 200)
        else:
            nome = request.args.get('nome', None)
            empresas = business_empresa.buscar_todos(nome)
            return empresas
    except Exception as e:
        traceback.print_exc()
        business_empresa.reconnect()
    return make_response(default_error, 404)


# @app_empresa.route('/<int:id>/', methods=['GET'])
# def get_empresa(id):
#     empresa = empresa_dao.get_by_id(id)
#     if not empresa:
#         return make_response({"error": "asdasdasd"}, 404)
#     return empresa.get_json()
