
  
    
    

    create  table
      "banking"."main"."dim_customers__dbt_tmp"
  
    as (
      select
  customer_id,
  first_name,
  last_name,
  email,
  join_date
from "banking"."main"."stg_customers"
    );
  
  