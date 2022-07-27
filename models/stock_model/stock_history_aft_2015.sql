{{ config(materialized='table') }}

with source_data as (

    SELECT * FROM US_STOCKS_DAILY.PUBLIC.STOCK_HISTORY
    where date >= '2015-01-01'

)

select *
from source_data
