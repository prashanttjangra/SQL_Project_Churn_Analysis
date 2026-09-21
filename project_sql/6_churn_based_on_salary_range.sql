SELECT
    CASE
        WHEN estimated_salary < 30000 THEN 'Low'
        WHEN estimated_salary < 60000 THEN 'Lower-Mid'
        WHEN estimated_salary < 100000 THEN 'Upper-Mid'
        ELSE 'High'
    END AS salary_segment,
    COUNT(*) AS customers,
    SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
    CAST(100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS churn_rate
FROM telco_clean
GROUP BY
    CASE
        WHEN estimated_salary < 30000 THEN 'Low'
        WHEN estimated_salary < 60000 THEN 'Lower-Mid'
        WHEN estimated_salary < 100000 THEN 'Upper-Mid'
        ELSE 'High'
    END
ORDER BY churn_rate DESC