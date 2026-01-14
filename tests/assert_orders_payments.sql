with orders as (
    select 
        order_id,
        total_amount
    from {{ ref('orders') }}
),

order_items_summed as (
    select 
        order_id,
        sum(line_total) as calculated_total
    from {{ ref('order_items') }}
    group by order_id
)

select 
    o.order_id,
    o.total_amount,
    oi.calculated_total
from orders o
join order_items_summed oi on o.order_id = oi.order_id
where o.total_amount != oi.calculated_total