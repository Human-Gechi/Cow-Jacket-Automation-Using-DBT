with customers as (
    select 
        email
    from {{ ref('customers') }}
),

select 
    *
FROM customers
WHERE REGEXP_LIKE(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$')