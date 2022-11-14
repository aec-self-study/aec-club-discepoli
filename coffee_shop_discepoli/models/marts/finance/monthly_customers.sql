{{
    config(
        materialized='table'
    )
}}

SELECT
    DATE_TRUNC(DATE(first_order_at), MONTH) as month
    , COUNT(customer_id) as customers
FROM {{ref('customers')}}
GROUP BY 1