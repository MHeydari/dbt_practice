
  
  create view "banking"."main"."stg_accounts__dbt_tmp" as (
    select
  account_id,
  customer_id,
  account_type,
  cast(open_date as date) as open_date
from "banking"."main"."accounts"
  );
