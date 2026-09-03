select
    account_id,
    customer_id,
    upper(account_type) as account_type,
    upper(currency) as currency,
    cast(created_at as date) as created_at

from {{ source('raw', 'accounts') }}
