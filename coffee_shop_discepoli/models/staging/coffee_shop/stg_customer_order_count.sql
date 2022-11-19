{{
  config(
    materialized='table'
  )
}}

with customers as (
  select * from {{ ref('src_coffee_shop__customers')}}
)

, orders as (
    select * from {{ ref('src_coffee_shop__orders')}}
)

select
  customers.customer_id
  , customers.customer_name
  , customers.email
  , min(orders.ordered_at) as first_order_at
  , count(distinct orders.order_id) as num_orders
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY 1,2,3
ORDER by first_order_at
