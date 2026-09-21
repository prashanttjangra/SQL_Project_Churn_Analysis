SELECT
    telecom_partner,
    state,
    COUNT(*) AS customers,
    SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
    CAST(100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS churn_rate
FROM telco_clean
GROUP BY telecom_partner, state
-- applied a minimum sample-size threshold of 20 customers to reduce misleading churn rates caused by very small customer group
HAVING COUNT(*) >= 20
ORDER BY churn_rate DESC