{{ config(
    materialized='incremental',
    unique_key='payment_id'
) }}

select
    payment_id,
    payment_date,
    customer_id,
    account_id,
    merchant_id,
    amount,
    payment_currency,
    status

from {{ ref('int_payment_details') }}

{% if is_incremental() %}

where payment_date >= (
    select dateadd(day, -2, max(payment_date))
    from {{ this }}
)

{% endif %}
