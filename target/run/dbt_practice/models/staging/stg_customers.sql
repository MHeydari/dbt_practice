
  
  create view "banking"."main"."stg_customers__dbt_tmp" as (
    select
  customer_id,
  first_name,
  last_name,
  email,
  cast(join_date as date) as join_date
from "banking"."main"."customers"
  );
