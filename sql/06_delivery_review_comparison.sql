USE olist;

SELECT
    CASE
        WHEN delay_days > 0 THEN 'late'
        ELSE 'on_time_or_early'
    END AS delivery_status,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(AVG(delivery_days), 2) AS avg_delivery_days,
    ROUND(AVG(delay_days), 2) AS avg_delay_days,
    ROUND(AVG(review_score), 2) AS avg_review_score,
    ROUND(AVG(CASE WHEN review_score = 1 THEN 1 ELSE 0 END), 4) AS one_star_rate,
    ROUND(AVG(CASE WHEN review_score <= 2 THEN 1 ELSE 0 END), 4) AS low_score_rate
FROM order_base
WHERE order_status = 'delivered'
  AND delivery_days IS NOT NULL
  AND delay_days IS NOT NULL
  AND review_score IS NOT NULL
GROUP BY
    CASE
        WHEN delay_days > 0 THEN 'late'
        ELSE 'on_time_or_early'
    END
ORDER BY
    delivery_status;