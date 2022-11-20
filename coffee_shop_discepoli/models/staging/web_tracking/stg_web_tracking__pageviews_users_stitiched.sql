with original as (
    select * from {{ ref('stg_web_tracking__pageviews')}}
)
, visitor_ids_per_customer as (
    select * from {{ ref('stg_web_tracking__visitor_ids_per_customer')}}
)
select
    /* Primary Key */
    original.event_id

    /* Foreign Keys */
    , visitor_ids_per_customer.first_visitor_id as visitor_id
    , original.customer_id

    /* Properties */
    , original.page_name
    , original.device_type
    
    /* Timestamps */
    , original.page_viewed_at

from original
left join visitor_ids_per_customer using(customer_id)