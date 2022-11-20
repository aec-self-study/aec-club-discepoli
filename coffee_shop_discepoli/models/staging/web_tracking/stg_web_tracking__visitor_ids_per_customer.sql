with source as (
    select * from {{ ref('stg_web_tracking__pagivews') }}
),

renamed as (
    select
        /* Primary Key */
        customer_id

        /* Foreign Keys */
        , visitor_id

        /* Properties */
        , device_type
        
        /* Timestamps */
        , min(viewed_at) as first_logged_in_at
        
    from source 
    group by 1,2,3
)

select * from renamed