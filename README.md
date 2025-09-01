# DBT Practice
This is a sample data build tool project for practicing transformations.

How to install it:
    pip install dbt-duckdb

How to run it:
    dbt seed
    dbt run
    dbt test
    #dbt docs generate && dbt docs serve
    dbt docs generate
    dbt docs serve

End-to-End Steps in the project 
1. Seed: Load raw CSVs into DuckDB     
dbt seed
Action:
dbt reads the .csv files from the /seeds folder (customers.csv, accounts.csv, transactions.csv).
It creates tables in DuckDB with the same names (customers, accounts, transactions).
These are your raw data tables, representing what might normally come from an external ETL/ELT pipeline.
After this step, DuckDB has 3 raw tables.

2. Build staging models (cleaning raw data)
dbt run
Action:
1- dbt runs all SQL files under models/staging/.
The ref('customers') in that SQL tells dbt to pull from the seeded customers table.
These staging models are usually materialized as views (configurated in dbt_project.yml).
After this step, you get 3 staging views:
stg_customers, stg_accounts, stg_transactions
These are like “cleaned versions” of the raw tables.

3. Build marts (analytics-ready models)
dbt runs all SQL under models/marts/.
These are transformations that join multiple staging models together.
For example:
dim_customers is a cleaned customer dimension (like a lookup table).
dim_accounts joins accounts to customers.
fact_transactions joins transactions with accounts + customers.
These are materialized as tables (configurated in dbt_project.yml).
After this step, we will have analytics-ready tables:
dim_customers, dim_accounts, fact_transactions