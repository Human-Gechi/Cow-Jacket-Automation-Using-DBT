-- Calculating total loyalty_points accumulated by customers overtime
with loyal_points as (
    select * from {{ ref('stg_loyalty_points') }}
),

aggregated_points as (
    select
        customer_id,
        sum(points_earned) as total_points_earned,
        max(transaction_date) as last_activity_date,
        count(loyalty_id) as total_loyalty_transactions
    from loyal_points
    group by 1
)

select * from aggregated_points
