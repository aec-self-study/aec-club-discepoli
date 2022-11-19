with known_true as (
    select
        date_trunc(date(ordered_at), week) as dimension
        , sum(total) as measure
    from dbt_discepoli_coffee_shop.src_coffee_shop__orders
    group by 1
)

, in_question as (
    select
        week as dimension
        , sum(revenue) as measure
    from dbt_discepoli_finance.weekly_revenue
    group by 1
)

, test as (
    select
        dimension
        , known_true.measure = in_question.measure as passed
    from known_true
    join in_question using(dimension)
)

select * from test
where not passed