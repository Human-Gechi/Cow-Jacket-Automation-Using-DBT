-- Checking price * quantity in the products and orders_items table equals the line_total in the orders_items table
with products as (
    select 
        product_id,
        price
     from {{ ref('stg_products') }} -- products table
),

with orders_items as (
    select 
    product_id,
    quantity,
    line_total
    from {{ ref('stg_orders_items') }} -- orders_table 
),
-- Selection to verify claims that line_total should equal price* quantity
item_calculation as (
    select
        (p.price * o.quantity) as total
    from products as p
    inner join order_items as o on o.product_id = p.product_id
    where o.line_total != p.total
        
)