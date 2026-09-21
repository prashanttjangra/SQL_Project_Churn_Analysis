SELECT
    churn,
    COUNT(*) AS customers,
    CAST(AVG(calls_made) AS DECIMAL(5, 2)) AS avg_calls,
    CAST(AVG(sms_sent) AS DECIMAL(5, 2)) AS avg_sms,
    CAST(AVG(data_used) AS DECIMAL(10, 2)) AS avg_data,
    CAST(AVG(estimated_salary) AS DECIMAL(10, 2)) AS avg_salary
FROM telco_clean
GROUP BY churn