{% macro is_deposit(txn_type) %}
    case when {{ txn_type }} = 'Deposit' then 1 else 0 end
{% endmacro %}


{% macro generate_date_spine(start_date, end_date) %}
(
    with recursive dates as (
        select cast({{ start_date }} as date) as d
        union all
        select d + interval 1 day
        from dates
        where d + interval 1 day <= cast({{ end_date }} as date)
    )
    select d as date_day from dates
)
{% endmacro %}
