-- Selectting info about products using Jinja template ref
select
        product_id, 
        product_name, 
        category, 
        price

    from {{ source('cowjack', 'products') }}

