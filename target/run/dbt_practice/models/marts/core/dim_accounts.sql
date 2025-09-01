
  
    
    

    create  table
      "banking"."main"."dim_accounts__dbt_tmp"
  
    as (
      select
  a.account_id,
  a.account_type,
  a.open_date,
  c.customer_id,
  c.first_name,
  c.last_name
from "banking"."main"."stg_accounts" a
join "banking"."main"."dim_customers" c on a.customer_id = c.customer_id
    );
  
  