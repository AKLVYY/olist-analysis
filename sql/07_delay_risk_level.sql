USE olist;

SELECT
    CASE
        WHEN delay_days <= 0 THEN 'low_risk_on_time_or_early'
        WHEN delay_days <= 3 THEN 'medium_risk_late_0_3d'
        WHEN delay_days <= 7 THEN 'high_risk_late_3_7d'
        ELSE 'critical_risk_late_7d_plus'
    END AS delivery_risk_level,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(SUM(payment_total), 2) AS gmv,
    ROUND(AVG(delay_days), 2) AS avg_delay_days,
    ROUND(AVG(review_score), 2) AS avg_review_score,
    ROUND(AVG(CASE WHEN review_score = 1 THEN 1 ELSE 0 END), 4) AS one_star_rate,
    ROUND(AVG(CASE WHEN review_score <= 2 THEN 1 ELSE 0 END), 4) AS low_score_rate
FROM order_base
WHERE order_status = 'delivered'
  AND payment_total IS NOT NULL
  AND delay_days IS NOT NULL
  AND review_score IS NOT NULL
GROUP BY
    CASE
        WHEN delay_days <= 0 THEN 'low_risk_on_time_or_early'
        WHEN delay_days <= 3 THEN 'medium_risk_late_0_3d'
        WHEN delay_days <= 7 THEN 'high_risk_late_3_7d'
        ELSE 'critical_risk_late_7d_plus'
    END
ORDER BY
    MIN(delay_days);