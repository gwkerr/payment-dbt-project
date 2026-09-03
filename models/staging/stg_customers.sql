select
    customer_id,
    first_name,
    last_name,
    upper(country) as country,
    cast(created_at as date) as created_at

from {{ source('raw', 'customers') }}
