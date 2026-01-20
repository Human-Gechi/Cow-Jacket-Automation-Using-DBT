-- Order summmary of orders made by customer
With order_items as (
    select * from {{ ref('stg_order_items') }}
),

orders_summary as (
select 
    order_id,
    SUM(quantity) as total_items,
    SUM(line_total) as order_subtotal
from order_items
group by order_id
)

select * from orders_summary