select
  t.txn_id,
  t.txn_date,
  t.amount,
  t.txn_type,
  a.account_id,
  c.customer_id
from "banking"."main"."stg_transactions" t
join "banking"."main"."dim_accounts" a on t.account_id = a.account_id
join "banking"."main"."dim_customers" c on a.customer_id = c.customer_id