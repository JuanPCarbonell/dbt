WITH ORDERS AS(
    SELECT *
    FROM {{ ref('stg_jaffle_shop__orders') }}
),
PAYMENTS AS(
    SELECT *
    FROM {{ ref('stg_stripe__payments') }}
),
ORDER_PAYMENTS AS(
    SELECT 
        ORDER_ID,
        SUM(CASE WHEN STATUS = 'success' THEN AMOUNT END) AS AMOUNT
    FROM PAYMENTS
    GROUP BY ORDER_ID
),
FINAL AS(
    SELECT
        ORDERS.ORDER_ID,
        ORDERS.CUSTOMER_ID,
        ORDERS.ORDER_DATE,
        coalesce(ORDER_PAYMENTS.AMOUNT, 0) AS AMOUNT
    FROM ORDERS
    LEFT JOIN ORDER_PAYMENTS USING(ORDER_ID)
)

select * from FINAL
