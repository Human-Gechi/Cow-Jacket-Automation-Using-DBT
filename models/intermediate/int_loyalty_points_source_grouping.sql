-- Distribution of customer loyalty points
with loyalty_points as (
    select * from {{ ref('stg_loyalty_points') }}
),

grouped_by_source as (
    select
        source,
        sum(points_earned) as total_points
    from loyalty_points
    group by source
)

select * from grouped_by_source
