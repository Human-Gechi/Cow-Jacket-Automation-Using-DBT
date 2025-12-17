with loyalty_points as (
    select * from {{ ref('stg_loyalty_points') }}
),

grouped_by_source as (
    select
        source,
        sum(points_earned) as total_points
    from loyalty_points
    group by 1 
)

select * from grouped_by_source
