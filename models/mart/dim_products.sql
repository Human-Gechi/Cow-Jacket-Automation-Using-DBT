-- Grab basic product informationabout products and order_items
with products as (
    select * from {{ ref('stg_products') }}
),

-- Summarize sales data to know how many products were sold.
sales_performance as (
    select 
        product_id,
        sum(quantity) as total_units_sold,
        sum(line_total) as total_revenue
    from {{ ref('stg_order_items') }}
    group by 1
),

-- Combine everything into one table 
final as (
    select
        p.product_id,
        p.product_name,
        p.category,
        p.price as current_unit_price,
        sp.total_units_sold,
        sp.lifetime_product_revenue
    from products p
    -- Left join so we still see products that haven't sold any units yet
    left join sales_performance sp on p.product_id = sp.product_id
)

select * from final
