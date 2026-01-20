-- Selectting info about customers using Jinja template ref
select
        customer_id,
        full_name,
        email,
        join_date

    from {{ source('cowjack', 'customers') }}




