# DBT Practice
This is a sample of [Data Build Tool project](https://github.com/dbt-labs/dbt-core) for practicing data transformations.

DBT focuses on transformations (the “T” in ELT) by letting us write SQL models and organize them in a structured approach.
DBT helps data teams transform raw data into analytics-ready datasets inside a data warehouse (like Snowflake, BigQuery, Redshift, or Postgres) </br>
Extracting and loading data into the warehouse is typically done using tools like Fivetran, Airbyte, or custom pipelines.</br>
To create a working sample, first, we make some row data samples inside DuckDB (using CSV files), then we practice some basic transformations.

## How to prepare the dependencies and environment:
    pip install dbt-duckdb

## How to run the project:
    dbt seed
    dbt run
    dbt test    
    dbt docs generate
    dbt docs serve

## Explaining the End-to-End steps
**1. Seed**: Load raw CSVs into DuckDB 

    dbt seed

dbt reads the .csv files from the /seeds folder (customers.csv, accounts.csv, transactions.csv).
It creates tables in DuckDB with the same names (customers, accounts, transactions).
These are our raw data tables, representing what might normally come from an external ETL/ELT pipeline.

✅After this step, DuckDB has 3 raw tables.

**2. Building models (cleaning raw data)**

    dbt run
1- Building staging models: dbt runs all SQL files under models/staging/.
The ref('customers') in that SQL tells dbt to pull from the seeded customers table.
These staging models are usually materialized as views (configurated in dbt_project.yml).

✅After this step, we will have 3 staging views:
- stg_customers
- stg_accounts
- stg_transactions

These are like “cleaned versions” of the raw tables.

2- Build marts (analytics-ready models)
dbt runs all SQL under models/marts/.
These are transformations that join multiple staging models together.
For example:
dim_customers is a cleaned customer dimension (like a lookup table).
dim_accounts joins accounts to customers.
fact_transactions joins transactions with accounts + customers.
These are materialized as tables (configurated in dbt_project.yml). 

✅After this step, we will have analytics-ready tables:
1. dim_customers 
2. dim_accounts
3. fact_transactions


**3. Testing data quality**

    dbt test
dbt runs checks defined in schema.yml.

Example:

Ensure customer_id is unique and not null in stg_customers.
Ensure account_id is unique in stg_accounts.
Ensure relationships (account.customer_id must exist in customers).

✅ After this step, we’re sure our data model is valid and consistent.

**4. Documentation**

    dbt docs generate 
    dbt docs serve

dbt generates an HTML site with:

- A DAG graph showing how transactions → stg_transactions → fact_transactions.
- Model descriptions (from schema.yml).
- Column-level tests and documentation.

✅ After this step, we can explore the project visually

## Sample output
Now we can query some results inside the DB (using DuckDB CLI). <be>
Running

    select *
    from daily_account_balances
    where account_id = 1001
    order by date_day
    limit 20;

Will result in:

    ┌────────────┬────────────┬─────────┐
    │  date_day  │ account_id │ balance │
    │    date    │   int32    │ int128  │
    ├────────────┼────────────┼─────────┤
    │ 2021-01-01 │       1001 │       0 │
    │ 2021-01-02 │       1001 │       0 │
    │ 2021-01-03 │       1001 │       0 │
    │ 2021-01-04 │       1001 │       0 │
    │ 2021-01-05 │       1001 │       0 │
    │ 2021-01-06 │       1001 │       0 │
    │ 2021-01-07 │       1001 │       0 │
    │ 2021-01-08 │       1001 │       0 │
    │ 2021-01-09 │       1001 │       0 │
    │ 2021-01-10 │       1001 │    2500 │
    │ 2021-01-11 │       1001 │    2500 │
    │ 2021-01-12 │       1001 │    2500 │
    │ 2021-01-13 │       1001 │    2500 │
    │ 2021-01-14 │       1001 │    2500 │
    │ 2021-01-15 │       1001 │    2500 │
    │ 2021-01-16 │       1001 │    2500 │
    │ 2021-01-17 │       1001 │    2500 │
    │ 2021-01-18 │       1001 │    2500 │
    │ 2021-01-19 │       1001 │    2500 │
    │ 2021-01-20 │       1001 │    2500 │
    ├────────────┴────────────┴─────────┤
    │ 20 rows                 3 columns │
    └───────────────────────────────────┘
