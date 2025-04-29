select
    ID AS PAYMENT_ID, 
    ORDERID as ORDER_ID, 
    PAYMENTMETHOD AS PAYMENT_METHOD, 
    STATUS, 
    AMOUNT / 100 AS AMOUNT, 
    CREATED AS CREATED_AT
from {{ source('stripe', 'payment') }}