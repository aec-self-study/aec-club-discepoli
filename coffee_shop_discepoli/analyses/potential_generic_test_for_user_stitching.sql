select 
  customer_id
  , count(distinct visitor_id) as count
from dbt_discepoli_web_tracking.stg_web_tracking__pageviews_users_stitiched
where customer_id is not null
group by 1 
having count > 1
