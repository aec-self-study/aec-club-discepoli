with source as (
  select * from {{ ref('stg_web_tracking__pageviews') }}
)

, aggregations as (
  select
    visitor_id
    , customer_id
    , session_id
    , count(*) as pageviews
    , min(page_viewed_at) as session_started_at
    , max(page_viewed_at) as session_ended_at
    , sum(case when page_name = 'order-confirmation' then 1 else 0 end) as purchase_count
  from source
  group by 1,2,3
)

, session_length as (
  select
    *
    , round(timestamp_diff(session_ended_at, session_started_at, second)/60,2) as session_length_minutes
  from aggregations
)

select * from session_length
