select
  customer_id,
  first_name,
  last_name,
  email,
  cast(join_date as date) as join_date
from {{ ref('customers') }}
