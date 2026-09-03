select
    customer_id,
    first_name,
    last_name,
    country,
    created_at

from {{ ref('stg_customers') }}
