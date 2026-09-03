select
    c.customer_id,
    c.first_name,
    c.last_name,
    c.country as customer_country,
    c.created_at as customer_created_at,

    a.account_id,
    a.account_type,
    a.currency as account_currency,
    a.created_at as account_created_at

from {{ ref('stg_customers') }} c

left join {{ ref('stg_accounts') }} a
    on c.customer_id = a.customer_id

