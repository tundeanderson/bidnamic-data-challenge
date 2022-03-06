import os, logging, sys
import pyodbc
from dotenv import load_dotenv

load_dotenv()

class DatabaseClient():
    def __init__(self):
        self._server = os.getenv('DB_SERVER_ADDRESS')
        self._database = os.getenv('DB_NAME')
        self._username = os.getenv('DB_USER')
        self._password = os.getenv('DB_PWD')

        self._conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+self._server+';DATABASE='+self._database+';UID='+self._username+';PWD='+self._password, autocommit=True)
        self._cursor = self._conn.cursor()

        try:
            self._cursor.execute("SELECT @@version;") 
            self._cursor.fetchone() 
        except Exception as e:
            logging.error(f'Encountered an issue establishing a connection to {self._database} database on {self._server}: {e}')
            sys.exit(0)

        logging.info(f'Successfully connected to {self._database} database.')

    def _execute_sp(self, sql, data, batch_size=1000):
        try:
            while len(data) > 0:
                batch = data[:min(len(data), batch_size)]
                data = data[min(len(data), batch_size):]
                self._cursor.execute(sql, (batch, ))
        except Exception as e:
            logging.error(f'Encountered an issue calling stored procedure on {self._database} database on {self._server}: {e}')
            sys.exit(0)

    def upsert_campaigns(self, data):
        sql = "{CALL dbo.UpsertCampaigns (?)}"
        self._execute_sp(sql, data)

    def upsert_adgroups(self, data):
        sql = "{CALL dbo.UpsertAdgroups (?)}"
        self._execute_sp(sql, data)

    def upsert_searchterms(self, data):
        sql = "{CALL dbo.UpsertSearchTerms (?)}"
        self._execute_sp(sql, data)