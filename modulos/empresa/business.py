import traceback

from modulos.empresa.dao import DaoEmpresa
from modulos.empresa.empresa import Empresa
from utils import BaseValidate


class BusinessEmpresa(BaseValidate):

    def __init__(self):
        self.empresa_dao = DaoEmpresa()

    def _validate_nome(self, value):
        if not value:
            return 'Este campo é obrigatório'
        return None

    def _validate_cnpj(self, value):
        if not value:
            return 'Este campo é obrigatório'
        if not str(value).isdigit():
            return 'Este campo deve ser somente números'
        if len(str(value)) != Empresa.MAX_LENGTH_NOME:
            return 'O campo cnpj deve ter no máximo {}, ele contêm {} caracteres'.format(Empresa.MAX_LENGTH_NOME, len(str(value)))
        if self.empresa_dao.get_by_cnpj(value):
            return 'Já existe uma empresa com esse cnpj'
        return None

    def validar_campos(self, data, campos):
        mensagem_error = {}
        flag_error = False
        for campo in campos:
            func_name = '_validate_{}'.format(campo)
            func = hasattr(self, func_name)
            if func:
                func = getattr(self, func_name)
                data_value = func(data.get(campo, None))
                if data_value is not None:
                    mensagem_error[campo] = data_value
                    flag_error = True
        return flag_error, mensagem_error

    def salvar(self, data):
        empresa = Empresa(**data)
        empresa = self.empresa_dao.save(empresa)
        return empresa

    def buscar_todos(self, filtro_nome):
        empresas = self.empresa_dao.select_all(filtro_nome)
        return empresas

    def reconnect(self):
        self.empresa_dao.closed_and_new_connection()
