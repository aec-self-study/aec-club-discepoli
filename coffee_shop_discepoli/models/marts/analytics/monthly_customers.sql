{{
    config(
        materialized='table'
    )
}}

SELECT
    DATE_TRUNC(DATE(first_order_at), MONTH) as month
    , COUNT(customer_id) as customersg
FROM {{ref('customers')}}
GROUP BY 1