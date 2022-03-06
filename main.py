from services.database_client import DatabaseClient
from services.extract_processor import ExtractProcessor

db_client = DatabaseClient()

processor = ExtractProcessor(db_client)

processor.process_campaigns('campaigns.csv')
processor.process_adgroups('adgroups.csv')
processor.process_searchterms('search_terms.csv')
