with source as (
    select * from {{ source('web_tracking', 'pageviews') }}
),

renamed as (
    select
        id as event_id
        , visitor_id
        , customer_id
        , page as page_name
        , device_type
        , timestamp as page_viewed_at
        , lag(timestamp) over (partition by visitor_id order by timestamp) as last_page_viewed_at_for_visitor
    
    from source 
)

, time_from_last_pageview as (
    select
        *
        , case
            /* if the diff between the current event and the last event 
            for the visitor is more than 30, it's a new session */
            when timestamp_diff(page_viewed_at, last_page_viewed_at_for_visitor, minute) >= 30
            then 1 else 0 
          end as is_new_session
    from renamed
)

, session_numbers as (
    select 
    *
    , sum(is_new_session) over (partition by visitor_id order by page_viewed_at) as session_number
  from time_from_last_pageview
  order by page_viewed_at
)

, session_ids as (
    select
         /* Primary Key */
         event_id

         /* Foreign Keys */
        , visitor_id
        , customer_id

        /* Properties */
        , to_hex(md5(concat(visitor_id, session_number))) as session_id
        , page_name
        , device_type

        /* Timestamps */
        , page_viewed_at

    from session_numbers
    order by visitor_id, page_viewed_at
)
select * from session_ids