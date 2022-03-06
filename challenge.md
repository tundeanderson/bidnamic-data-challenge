Thank you for inviting me to take your below challenge. 

I have tried to keep the python code as simple as possible utilising SQL servers' ability to automatically cast to SQL types from strings. Given more time it might have been interesting to investigate if there was a performance hit for this - I suspect it may be faster to limit how much of this SQL has to do, but it would make for slightly more complex code. If the performance of this task was a major factor then I would have probably avoided this.

It has been written with Python 3.7.6 and SQL Server 2017 (linux).

Steps to run:

- Run SQL DB creation script
- Run SQL table creation scripts
- Run SQL SP creation scripts
- Run SQL user creation script
- In python: pip install -r requirements.txt
- Edit .env file update db name, server address etc
- Extract extracts\extracts.rar (GitHub file size limit)
- python main.py (currently runs for all 3 extracts, edit if you want to run 1 at a time)

<img src="logo.png" alt="drawing" width="500"/>

## Python Data Engineering Challenge

Our system ingests search term data from Google Ads API into a PostgreSQL database, via an AWS S3 Data Lake.

Once ingested we score each search term with its Return On Ad Spend (ROAS).

```text
ROAS = conversion value / cost
```


### Task

Three CSVs have been given - campaigns.csv, adgroups.csv and search_terms.csv. 

First ingest these 3 CSVs into a database, ensure the data ingestion is idempotent. 

Secondly, the adgroup alias is in the format:

`Shift - Shopping - <country> - <campaign structure value> - <priority> - <random string> - <hash>`

We sometimes need to know the ROAS aggregated by `country` and/or by `priority`. 

Build something to allow for those aggregations to be queried easily.


### Submission

Please fork this repo to complete the challenge, once done email back link to your repo.

Good luck we are rooting for you!