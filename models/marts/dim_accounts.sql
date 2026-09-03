select
    account_id,
    customer_id,
    account_type,
    currency,
    created_at

from {{ ref('stg_accounts') }}
