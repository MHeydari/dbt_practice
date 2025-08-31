select
  customer_id,
  first_name,
  last_name,
  email,
  join_date
from {{ ref('stg_customers') }}
