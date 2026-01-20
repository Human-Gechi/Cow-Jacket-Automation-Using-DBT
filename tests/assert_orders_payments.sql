-- Testing order and order_items
with orders as (
    select 
        order_id,
        total_amount
    from {{ ref('orders') }} -- orders table
),

order_items_summed as (
    select 
        order_id,
        sum(line_total) as calculated_total
    from {{ ref('order_items') }}
    group by order_id --order_items
)

select 
    o.order_id, -- order_id
    o.total_amount, -- total_amount from the orders table
    oi.calculated_total -- calculate_total ; total of each prodcut in the prder_items made by a customer
from orders o
join order_items_summed oi on o.order_id = oi.order_id
where o.total_amount != oi.calculated_total
