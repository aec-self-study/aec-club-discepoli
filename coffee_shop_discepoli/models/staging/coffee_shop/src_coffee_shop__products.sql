with source as (
    select * from {{ source('coffee_shop', 'products') }}
),

renamed as (
    select
        /* Primary Key */
        id as product_id

        /* Properties */ 
        , name
        , category

        /* Timestamps */
        , created_at
        
    from source
)

select * from renamed