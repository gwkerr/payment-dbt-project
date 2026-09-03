select
    merchant_id,
    merchant_name,
    merchant_country

from {{ ref('stg_merchants') }}
