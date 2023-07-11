from flask import Flask, request, Response, make_response

from modulos.empresa.dao_empresa import DaoEmpresa
from modulos.empresa.empresa import Empresa

POST = 'POST'

app = Flask(__name__)
empresa_dao = DaoEmpresa()

@app.route('/', methods=['GET'])
def home():
    print('HOME')
    print(request)
    print('\n'.join(dir(request)))
    print('aaaaaaaaaaaaaaaa')
    print(request.headers)
    return {}


@app.route('/empresa/', methods=['GET', POST])
def get():
    if request.method == POST:
        data = request.get_json()
        empresa = Empresa(**data)
        id = empresa_dao.save(empresa)
        return make_response({"id": id}, 200)

    nome = request.args.get('nome', None)
    empresas = empresa_dao.select_all(nome)
    return empresas


@app.route('/empresa/<int:id>/',methods=['GET'])
def get_empresa(id):
    empresa = empresa_dao.get_by_id(id)
    if not empresa:
        return make_response({"error": "asdasdasd"}, 404)
    return empresa.get_json()


app.run()
