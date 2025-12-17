
select
        loyalty_id,
        customer_id, 
        points_earned, 
        transaction_date, 
        source

    from {{ source('cowjack', 'loyalty_points') }}
