select
  txn_id,
  account_id,
  cast(txn_date as date) as txn_date,
  amount,
  txn_type
from {{ ref('transactions') }}
