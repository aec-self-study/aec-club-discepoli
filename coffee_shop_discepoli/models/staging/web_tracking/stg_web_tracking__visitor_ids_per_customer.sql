with source as (
    select * from {{ ref('stg_web_tracking__pageviews') }}
),

renamed as (
    select
        customer_id
        , min(page_viewed_at) as first_logged_in_at
    from source 
    group by 1
)

, final as (
  select
    customer_id
    , source.visitor_id as first_visitor_id
    , source.page_name as firs_page_name
    , source.device_type as first_device_type
    , renamed.first_logged_in_at
    , row_number() over (partition by customer_id order by page_name) as row_num
  from renamed
  join source using(customer_id)
  where renamed.first_logged_in_at = source.page_viewed_at
)

select 
    * --except(row_num) 
from final
where row_num = 1