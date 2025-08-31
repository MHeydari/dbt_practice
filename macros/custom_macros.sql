{% macro is_deposit(txn_type) %}
    case when {{ txn_type }} = 'Deposit' then 1 else 0 end
{% endmacro %}
