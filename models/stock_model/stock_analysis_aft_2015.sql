{{ config(materialized='table') }}

with source_data as (

    SELECT * FROM US_STOCKS_DAILY.PUBLIC.stock_history
    where date >= '2015-01-01'

)

select *
from source_data
