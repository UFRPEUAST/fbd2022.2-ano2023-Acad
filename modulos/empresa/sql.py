

class SQLEmpresa(object):
    TABLE = 'empresa'
    COLUMN_NAME = 'nome'
    SELECT_ALL = f'SELECT * FROM {TABLE}'
    SELECT_BY_ID = "SELECT * FROM {} WHERE ID={}"
    SELECT_ALL_SEARCH = "SELECT * from {} where {} ilike '%{}%'"
    INSERT = "INSERT INTO {} (nome, cnpj) VALUES ('{}', '{}') returning id"