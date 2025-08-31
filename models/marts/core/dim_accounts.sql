select
  a.account_id,
  a.account_type,
  a.open_date,
  c.customer_id,
  c.first_name,
  c.last_name
from {{ ref('stg_accounts') }} a
join {{ ref('dim_customers') }} c on a.customer_id = c.customer_id
