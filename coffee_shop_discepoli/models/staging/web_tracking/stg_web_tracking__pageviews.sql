with source as (
    select * from {{ source('web_tracking', 'pageviews') }}
),

renamed as (
    select
        /* Primary Key */
        id as event_id

        /* Foreign Keys */
        , visitor_id
        , customer_id

        /* Properties */
        , page as page_name
        , device_type
        
        /* Timestamps */
        , timestamp as page_viewed_at
    
    from source 
)

select * from renamed