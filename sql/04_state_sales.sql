USE olist;

SELECT
    customer_state,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT customer_unique_id) AS customers,
    ROUND(SUM(payment_total), 2) AS gmv,
    ROUND(
        SUM(payment_total) / SUM(SUM(payment_total)) OVER (),
        4
    ) AS gmv_share,
    ROUND(AVG(payment_total), 2) AS avg_order_value,
    ROUND(AVG(freight_total), 2) AS avg_freight
FROM order_base
WHERE order_status = 'delivered'
  AND payment_total IS NOT NULL
  AND price_total IS NOT NULL
  AND freight_total IS NOT NULL
GROUP BY
    customer_state
ORDER BY
    gmv DESC
LIMIT 10;