with 
  weekly_revenue_base as (
  select * from {{ ref('int_coffee_shop__weekly_revenue_base') }}
)

, max_customer_week_number as (
    select 
        customer_id
        , max(customer_week_number) as max_week_number
    from weekly_revenue_base
    group by 1
)
, all_weeks_per_customer as (
    select 
        customer_id
        , generated_week_number
    from max_customer_week_number
    join unnest(
        generate_array(1,999)
    ) as generated_week_number 
      on generated_week_number <= max_week_number
)
, weekly_customer_revenue as (
  select
    all_weeks_per_customer.customer_id
    , all_weeks_per_customer.generated_week_number as week
    , coalesce(sum(price), 0) as revenue
  from all_weeks_per_customer
  left join weekly_revenue_base 
        on all_weeks_per_customer.customer_id = weekly_revenue_base.customer_id
        and all_weeks_per_customer.generated_week_number = weekly_revenue_base.customer_week_number
  group by 1,2
  order by 1,2
)

select
  to_hex(md5(concat(customer_id, week))) as primary_key
  , *
  , sum(revenue) over(
    partition by customer_id
    order by week
    rows unbounded preceding
  ) as cumulative_revenue
from weekly_customer_revenue