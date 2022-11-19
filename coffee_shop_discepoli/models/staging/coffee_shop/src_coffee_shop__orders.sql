with source as (
    select * from {{ source('coffee_shop', 'orders') }}
),

renamed as (
    select
        /* Primary Key */
        id as order_id

        /* Foreign Keys */
        , customer_id

        /* Properties */ 
        , total
        , address
        , state
        , zip
        
        /* Timestamps */
        , created_at as ordered_at
        
    from source
)

select * from renamed
