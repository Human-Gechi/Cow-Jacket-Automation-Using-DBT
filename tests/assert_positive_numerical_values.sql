-- Verifying Numerical columns (price,quantity, total_items, line_total) are not less than 0
with products as (
    select 
        product_id, 
        price 
    from {{ ref('stg_products') }} -- products table
),

order_items as (
    select 
        order_item_id, 
        quantity, 
        line_total 
    from {{ ref('stg_order_items') }} -- orders_items table
),

orders as (
    select 
        order_id, 
        total_amount  
    from {{ ref('stg_orders') }} --orders table
)

--- Imaginary columns were created because union all works only on tables having the same columns  
select 
    'product' as record_type,
    product_id as record_id,
    price as invalid_value
from products 
where price <= 0 -- Checking price is less than zero

union all

select 
    'order_item' as record_type,
    order_item_id as record_id,
    quantity as invalid_value
from order_items
where quantity <= 0 or line_total <= 0 -- checking if quantity and line_total is not less than zero

union all

select 
    'order' as record_type,
    order_id as record_id,
    total_amount as invalid_value
from orders 
where total_amount <= 0 -- Checking total_amount is not less