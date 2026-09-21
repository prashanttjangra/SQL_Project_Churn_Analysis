SELECT
    COUNT(*) as total_customers,
    SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) as churned_customers,
    SUM(CASE WHEN churn = 0 THEN 1 ELSE 0 END) as retained_customers,
    CAST(100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5, 2)) AS churned_rate
FROM telco_clean