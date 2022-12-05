with customers as (
  select * from {{ ref('stg_coffee_shop__customers')}}
)

, orders as (
    select * from {{ ref('stg_coffee_shop__orders')}}
)

select
  customers.customer_id
  , customers.customer_name
  , customers.email
  , min(orders.ordered_at) as first_ordered_at
  , count(distinct orders.order_id) as num_orders
from customers
join orders on customers.customer_id = orders.customer_id
group by 1,2,3
order by first_ordered_at