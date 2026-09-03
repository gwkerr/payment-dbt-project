select
    merchant_id,
    merchant_name,
    upper(merchant_country) as merchant_country

from {{ source('raw', 'merchants') }}
