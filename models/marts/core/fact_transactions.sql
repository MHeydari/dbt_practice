select
  t.txn_id,
  t.txn_date,
  t.amount,
  t.txn_type,
  a.account_id,
  c.customer_id
from {{ ref('stg_transactions') }} t
join {{ ref('dim_accounts') }} a on t.account_id = a.account_id
join {{ ref('dim_customers') }} c on a.customer_id = c.customer_id
