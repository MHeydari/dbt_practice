
  
  create view "banking"."main"."stg_transactions__dbt_tmp" as (
    select
  txn_id,
  account_id,
  cast(txn_date as date) as txn_date,
  amount,
  txn_type
from "banking"."main"."transactions"
  );
