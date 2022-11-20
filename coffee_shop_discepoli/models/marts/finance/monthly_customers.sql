{{
    config(
        materialized='table'
    )
}}

SELECT
    DATE_TRUNC(DATE(first_order_at), MONTH) as month
    , COUNT(customer_id) as customers
FROM {{ref('int_coffee_shop__customer_order_count')}}
GROUP BY 1