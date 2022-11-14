{{
  config(
    materialized='table'
  )
}}

with customers as (
  select * from {{ ref(source_coffee_shop__customers) }}
)

, orders as (
    select * from {{ ref(source_coffee_shop__orders) }}
)

select
  customers.id as customer_id
  , customers.name
  , customers.email
  , min(orders.created_at) as first_order_at
  , count(distinct orders.id) as num_orders
  , count(orders.id) as order_distinct_check
FROM customers
JOIN orders ON customers.id = orders.customer_id
GROUP BY 1,2,3
ORDER by first_order_at