from connection.ServerConnection import ConnectDataBase
from modulos.empresa.empresa import Empresa
from modulos.empresa.sql import SQLEmpresa

class DaoEmpresa(SQLEmpresa):

    def __init__(self):
        self.connect = ConnectDataBase()
        self.cursor = self.connect.get_cursor()

    def select_all(self, search):
        sql = self.SELECT_ALL
        if search:
            sql = self.SELECT_ALL_SEARCH.format(self.TABLE, self.COLUMN_NAME, search)
        self._execute_sql(sql)
        empresas = self.cursor.fetchall()
        empresas_list = []
        for empresa in empresas:
            data = dict(zip(self.columns_name, empresa))
            empresas_list.append(data)
        return empresas_list

    def get_by_id(self, id):
        sql = self.SELECT_BY_ID.format(self.TABLE, id)
        self._execute_sql(sql)
        empresa = self._create_object(self.cursor.fetchone())
        return empresa

    def _create_object(self, data):
        if data:
            data = dict(zip(self.columns_name, data))
            empresa = Empresa(**data)
            return empresa
        return None

    def save(self, empresa):
        sql = self.INSERT.format(self.TABLE, empresa.nome, empresa.cnpj)
        cursor = self.connect.get_cursor()
        cursor.execute(sql)
        self.connect.commit()
        data = cursor.fetchone()
        return data[0]


    def _execute_sql(self, sql, insert=False):
        self.cursor.execute(sql)
        if insert:
            return
        self.columns_name = [desc[0] for desc in self.cursor.description]