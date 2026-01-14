with products as (
    select 
        product_id,
        price
     from {{ ref('stg_products') }}
),

with orders_items as (
    select 
    product_id,
    quantity,
    line_total
    from {{ ref('stg_orders_items') }}
),

item_calculation as (
    select
        (p.price * o.quantity) as total
    from products as p
    inner join order_items as o on o.product_id = p.product_id
    where o.line_total != p.total
        
)