with original as (
    select * from {{ ref('stg_web_tracking__pageviews')}}
)
, visitor_ids_per_customer as (
    select * from {{ ref('stg_web_tracking__visitor_ids_per_customer')}}
)

, session_metadata as (
    select * from {{ ref('int_web_tracking__session_metadata')}}
)
select
    /* Primary Key */
    original.event_id

    /* Foreign Keys */
    , coalesce(visitor_ids_per_customer.first_visitor_id, original.visitor_id) as visitor_id
    , original.customer_id

    /* Properties */
    , original.page_name
    , original.device_type
    
    /* Timestamps */
    , original.page_viewed_at
    , session_metadata.session_started_at
    , session_metadata.session_ended_at

from original
left join visitor_ids_per_customer using(customer_id)
left join session_metadata using(customer_id, session_id)