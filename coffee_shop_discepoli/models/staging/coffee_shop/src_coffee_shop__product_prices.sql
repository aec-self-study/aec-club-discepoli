with source as (
    select * from {{ source('coffee_shop', 'product_prices') }}
),

renamed as (
    select
        /* Primary Key */
        id as product_price_id
        /* Foreign Keys */
        , product_id

        /* Properties */ 
        , price

        /* Timestamps */
        , created_at
        , ended_at
        
    from source 
)

select * from renamed