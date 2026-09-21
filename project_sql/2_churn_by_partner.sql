SELECT
    telecom_partner,
    COUNT(*) as total_customers,
    SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) as churned_customers,
    CAST(100 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5, 2)) AS churn_rate
FROM telco_clean
GROUP BY telecom_partner
ORDER BY churn_rate DESC