class Empresa():
    def __init__(self, nome, cnpj, id=None):
        self.id = id
        self.nome = nome
        self.cnpj = cnpj
        self.attributes = ["id", "nome", "cnpj"]

    def __str__(self):
        return '{}-{}'.format(self.id, self.nome)

    def get_json(self):
        json_data = {}
        for attr in self.attributes:
            json_data[attr] = getattr(self, attr)
        return json_data
