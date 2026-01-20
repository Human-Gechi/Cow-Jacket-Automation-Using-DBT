-- Selectting info about orders using Jinja template ref
select
        order_id,
        customer_id,
        order_date,
        total_amount

    from {{ source('cowjack', 'orders') }}

