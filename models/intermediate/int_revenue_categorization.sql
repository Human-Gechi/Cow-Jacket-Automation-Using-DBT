-- Distribution of orders_items placed by customers and the products ordered.
with order_items as (
    select * from {{ ref('stg_order_items') }}
),

products as (
    select * from {{ ref('stg_products') }}
),
--- Joining order_items on products ordered
order_category as (
    select
        o_i.order_item_id,
        o_i.order_id,
        o_i.product_id,
        p.product_name,
        p.category as product_category,
        o_i.quantity,
        p.price as unit_price,
        o_i.line_total as reported_line_total,
        (o_i.quantity * p.price) as total_cost
    from order_items as o_i
    left join products as p
        on o_i.product_id = p.product_id
)

select * from order_category
