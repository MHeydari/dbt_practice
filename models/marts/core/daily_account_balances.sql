with date_spine as (

    {{ generate_date_spine("'2021-01-01'", "'2021-12-31'") }}

),

transactions as (
    select
        t.account_id,
        t.txn_date,
        sum(t.amount) over (
            partition by t.account_id
            order by t.txn_date
            rows between unbounded preceding and current row
        ) as running_balance
    from {{ ref('stg_transactions') }} t
),

daily_balances as (
    select
        d.date_day,
        a.account_id,
        coalesce(
            max(t.running_balance) filter (where t.txn_date <= d.date_day),
            0
        ) as balance
    from date_spine d
    cross join {{ ref('dim_accounts') }} a
    left join transactions t 
        on a.account_id = t.account_id
    group by d.date_day, a.account_id
)

select * from daily_balances
order by account_id, date_day
