with source as (
    select * from {{ ref('stg_web_tracking__pageviews') }}
),

renamed as (
    select
        customer_id
        , visitor_id
        , device_type
        , min(page_viewed_at) as first_logged_in_on_device_at
        
    from source 
    group by 1,2,3
)

select
    customer_id
    , first_value(visitor_id) over (
            partition by customer_id
            order by first_logged_in_on_device_at
            rows between unbounded preceding and unbounded following
        ) as first_visitor_id  
    , visitor_id
    , device_type
    , first_logged_in_on_device_at
from renamed