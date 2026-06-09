USE olist;

SELECT
    main_payment_type,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT customer_unique_id) AS customers,
    ROUND(SUM(payment_total), 2) AS gmv,
    ROUND(
        SUM(payment_total) / SUM(SUM(payment_total)) OVER (),
        4
    ) AS gmv_share,
    ROUND(AVG(payment_total), 2) AS avg_order_value,
    ROUND(AVG(payment_installments_max), 2) AS avg_installments
FROM order_base
WHERE order_status = 'delivered'
  AND payment_total IS NOT NULL
  AND price_total IS NOT NULL
  AND freight_total IS NOT NULL
  AND main_payment_type IS NOT NULL
GROUP BY
    main_payment_type
ORDER BY
    gmv DESC;