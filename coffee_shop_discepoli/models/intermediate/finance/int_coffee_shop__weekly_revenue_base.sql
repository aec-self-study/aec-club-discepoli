with orders as (
  select * from {{ ref('stg_coffee_shop__orders') }}
)

, order_items as (
  select * from {{ ref('stg_coffee_shop__order_items') }}
)
, products as (
  select * from {{ ref('stg_coffee_shop__products') }}
)

, product_prices as (
  select * from {{ ref('stg_coffee_shop__product_prices') }}
)

, customers_first_order as (
  select * from {{ ref('int_coffee_shop__customer_order_count') }}
)

select
    date_trunc(date(ordered_at), week) as week
    , cast(floor(date_diff(ordered_at, first_ordered_at, day)/7) + 1 as int64) as customer_week_number
    , orders.customer_id
    , product_category
    , if(first_ordered_at = ordered_at, 'new', 'returning') as customer_type 
    , price
from orders
join customers_first_order using(customer_id)
join order_items using(order_id)
join products using(product_id)
join product_prices 
  on products.product_id = product_prices.product_id 
 and ordered_at between price_valid_at and price_valid_until
