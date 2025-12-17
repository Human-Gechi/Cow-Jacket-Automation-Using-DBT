{{ config(materialized='table', schema='marts') }}

with products as (
    select * from {{ ref('stg_products') }}
),

sales_performance as (
    select 
        product_id,
        sum(quantity) as total_units_sold,
        sum(line_total) as total_revenue
    from {{ ref('stg_order_items') }}
    group by 1
),

final as (
    select
        p.product_id,
        p.product_name,
        p.category,
        p.price as current_unit_price,
        (sp.total_units_sold) as total_units_sold,
        (sp.total_revenue) as lifetime_product_revenue
    from products p
    left join sales_performance sp on p.product_id = sp.product_id
)

select * from final
