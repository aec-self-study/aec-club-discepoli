with source as (
    select * from {{ source('coffee_shop', 'products') }}
),

renamed as (
    select
        /* Primary Key */
        id as product_id

        /* Properties */ 
        , name as product_name
        , category as product_category

        /* Timestamps */
        , created_at as product_created_at
        
    from source
)

select * from renamed