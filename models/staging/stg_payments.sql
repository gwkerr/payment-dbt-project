select
    payment_id,
    account_id,
    merchant_id,
    cast(amount as number(18,2)) as amount,
    upper(currency) as currency,
    upper(status) as status,
    cast(payment_date as date) as payment_date

from {{ source('raw', 'payments') }}
