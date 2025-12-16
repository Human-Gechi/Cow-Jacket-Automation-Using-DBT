with customers as (

    select
        customer_id,
        full_name,
        email,
        join_date

    from {{ source('cowjack', 'customers') }}
)


select * from customers
