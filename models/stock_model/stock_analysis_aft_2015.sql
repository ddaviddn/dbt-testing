{{ config(materialized='table') }}

with stock as (

    SELECT 
        CP.SYMBOL,
        SH.DATE,
        SH.OPEN,
        SH.CLOSE,
        SH.LOW,
        SH.HIGH,
        CP.RANGE,
        CP.INDUSTRY,
        CP.SECTOR,
        CP.EXCHANGE,
        CP.BETA,
        DIV0(CP.LASTDIV, CP.PRICE) AS DIVIDEND_RATE
    FROM 
        US_STOCKS_DAILY.PUBLIC.COMPANY_PROFILE CP
    JOIN 
        {{ ref('stock_history_aft_2015') }} SH
    ON 
        CP.SYMBOL = SH.SYMBOL    
    WHERE
        CP.EXCHANGE NOT IN ('Other OTC', 'Brussels', 'MCX', 'Paris', 'Amsterdam', 'Lisbon', 'Swiss', 'Toronto', 'YHD')
        AND 
        CP.EXCHANGE IS NOT NULL
        AND
        CP.SYMBOL IN (SELECT SYMBOL FROM MY_STOCK.STOCK_INFO.ACTIVE_SYMBOLS)
    ORDER BY
        CP.SYMBOL, SH.DATE 

)

select *
from stock
