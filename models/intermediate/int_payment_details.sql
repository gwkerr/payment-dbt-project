select
    p.payment_id,
    p.payment_date,
    p.amount,
    p.currency as payment_currency,
    p.status,

    ca.account_id,
    ca.account_type,
    ca.customer_id,
    ca.first_name,
    ca.last_name,
    ca.customer_country,

    m.merchant_id,
    m.merchant_name,
    m.merchant_country

from {{ ref('stg_payments') }} p

left join {{ ref('int_customer_accounts') }} ca
    on p.account_id = ca.account_id

left join {{ ref('stg_merchants') }} m
    on p.merchant_id = m.merchant_id

