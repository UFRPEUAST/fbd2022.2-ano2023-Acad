import psycopg2


class ConnectDataBase:
    def __init__(self):
        self._connect = psycopg2.connect(
            host="localhost",
            database="FaculdadeFBD",
            user="postgres",
            password="postgres"
        )

    def get_cursor(self):
        return self._connect.cursor()

    def commit(self):
        self._connect.commit()