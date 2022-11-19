{{
    config(
        materialized='table'
    )
}}

SELECT
    DATE_TRUNC(DATE(first_order_at), MONTH) as month
    , COUNT(customer_id) as customers
FROM {{ref('stg_customer_order_count')}}
GROUP BY 1