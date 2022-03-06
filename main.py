from services.database_client import DatabaseClient
from services.extract_processor import ExtractProcessor

db_client = DatabaseClient()

processor = ExtractProcessor(db_client)

processor.process_campaigns('extracts\campaigns.csv')
processor.process_adgroups('extracts\\adgroups.csv')
processor.process_searchterms('extracts\search_terms.csv')
