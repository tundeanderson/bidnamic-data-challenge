import csv, sys, logging

class ExtractProcessor():
    def __init__(self, db_client):
        self._db_client=db_client

    def _process_extract(self, filename):
        def _process_fields(line, field_count):
            return tuple(line[i] for i in range(field_count))

        try:
            with open(filename, encoding='utf-8') as extract:
                reader = csv.reader(extract)
                fields = len(next(extract).split(','))

                result = [_process_fields(l, fields) for l in reader]

                return list(dict.fromkeys(result)) # remove duplicates

        except Exception as e:
            logging.error(f'Encountered an error reading from extract {filename}: {e}')
            sys.exit(0)

    def process_adgroups(self, filename):
        def append_country_and_priority(record):
            s = record[2].split(' - ')
            return (s[2], s[4], )

        records = self._process_extract(filename)
        records = [t + append_country_and_priority(t) for t in records]

        self._db_client.upsert_adgroups(records)

    def process_campaigns(self, filename):
        records = self._process_extract(filename)
        self._db_client.upsert_campaigns(records)

    def process_searchterms(self, filename):
        records = self._process_extract(filename)
        self._db_client.upsert_searchterms(records)