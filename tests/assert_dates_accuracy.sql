with customers as (
    select 
        customer_id,
        join_date
     from {{ ref('stg_customers') }}
),

orders as (
    select 
        customer_id,
        order_date
    from {{ ref('stg_orders') }}
)

select
    o.customer_id,
    c.join_date,
    o.order_date
from customers as c
join orders as o on o.customer_id = c.customer_id
where c.join_date > o.order_date