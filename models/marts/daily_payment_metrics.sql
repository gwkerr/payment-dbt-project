select
    payment_date,

    count(*) as total_payments,

    {{ payment_status_count('COMPLETED') }} as completed_payments,

    {{ payment_status_count('FAILED') }} as failed_payments,

    sum(
        case
            when status = 'COMPLETED' then amount
            else 0
        end
    ) as total_payment_volume,

    avg(
        case
            when status = 'COMPLETED' then amount
        end
    ) as avg_payment_amount,

    round(
        100.0 * count_if(status = 'FAILED')
        / nullif(count(*), 0),
        2
    ) as failure_rate_pct

from {{ ref('fct_payments') }}

group by payment_date
