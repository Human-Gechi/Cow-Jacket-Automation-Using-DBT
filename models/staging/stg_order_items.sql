-- Selectting info about order_items using Jinja template ref
select
        order_item_id, 
        order_id, 
        product_id, 
        quantity, 
        line_total

    from {{ source('cowjack', 'order_items') }}

