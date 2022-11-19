with orders as (
  select * from {{ ref('src_coffee_shop__orders') }}
)

, order_items as (
  select * from {{ ref('src_coffee_shop__order_items') }}
)
, products as (
  select * from {{ ref('src_coffee_shop__products') }}
)

, product_prices as (
  select * from {{ ref('src_coffee_shop__product_prices') }}
)

, customers_first_order as (
  select * from {{ ref('stg_customer_order_count') }}
)

, joined as (
  select
    date_trunc(date(ordered_at), week) as week
    , product_category
    , price
    , if(first_order_at = ordered_at, 'new', 'returning') as customer_type 
  from orders
  join customers_first_order using(customer_id)
  join order_items using(order_id)
  join products using(product_id)
  join product_prices 
    on products.product_id = product_prices.product_id 
   and ordered_at between price_valid_at and price_valid_until
)

select
  week
  , product_category
  , customer_type
  , sum(price) as revenue
from joined
group by 1,2,3
order by 1,2
