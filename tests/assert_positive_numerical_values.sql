with products as (
    select 
        product_id, 
        price 
    from {{ ref('stg_products') }}
),

order_items as (
    select 
        order_item_id, 
        quantity, 
        line_total 
    from {{ ref('stg_order_items') }}
),

orders as (
    select 
        order_id, 
        total_amount 
    from {{ ref('stg_orders') }}
)

select 
    'product' as record_type,
    product_id as record_id,
    price as invalid_value
from products
where price <= 0

union all

select 
    'order_item' as record_type,
    order_item_id as record_id,
    quantity as invalid_value
from order_items
where quantity <= 0 or line_total <= 0

union all

select 
    'order' as record_type,
    order_id as record_id,
    total_amount as invalid_value
from orders
where total_amount <= 0