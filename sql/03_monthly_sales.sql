USE olist;

SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(SUM(payment_total), 2) AS gmv,
    ROUND(AVG(payment_total), 2) AS avg_order_value
FROM order_base
WHERE order_status = 'delivered'
  AND payment_total IS NOT NULL
  AND price_total IS NOT NULL
  AND freight_total IS NOT NULL
GROUP BY
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m')
ORDER BY
    order_month;