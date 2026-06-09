USE olist;

WITH state_risk AS (
    SELECT
        customer_state,
        COUNT(DISTINCT order_id) AS orders,
        SUM(payment_total) AS gmv,
        AVG(CASE WHEN delay_days > 0 THEN 1 ELSE 0 END) AS late_rate,
        AVG(CASE WHEN review_score = 1 THEN 1 ELSE 0 END) AS one_star_rate,
        AVG(review_score) AS avg_review_score
    FROM order_base
    WHERE order_status = 'delivered'
      AND payment_total IS NOT NULL
      AND delay_days IS NOT NULL
      AND review_score IS NOT NULL
    GROUP BY
        customer_state
),
ranked AS (
    SELECT
        state_risk.*,
        RANK() OVER (ORDER BY gmv DESC) AS gmv_rank,
        RANK() OVER (ORDER BY late_rate DESC) AS late_rate_rank,
        RANK() OVER (ORDER BY one_star_rate DESC) AS one_star_rate_rank
    FROM state_risk
    WHERE orders >= 500
)
SELECT
    customer_state,
    orders,
    ROUND(gmv, 2) AS gmv,
    ROUND(late_rate, 4) AS late_rate,
    ROUND(one_star_rate, 4) AS one_star_rate,
    ROUND(avg_review_score, 2) AS avg_review_score,
    gmv_rank,
    late_rate_rank,
    one_star_rate_rank,
    gmv_rank + late_rate_rank + one_star_rate_rank AS priority_score
FROM ranked
ORDER BY
    priority_score
LIMIT 10;