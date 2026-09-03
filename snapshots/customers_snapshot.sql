{% snapshot customers_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='customer_id',
        strategy='check',
        check_cols=['first_name', 'last_name', 'country']
    )
}}

select
    customer_id,
    first_name,
    last_name,
    country,
    created_at

from {{ source('raw', 'customers') }}

{% endsnapshot %}
