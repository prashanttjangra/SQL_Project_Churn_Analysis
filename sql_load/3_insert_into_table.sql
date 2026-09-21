INSERT INTO telco_clean
SELECT
    CAST(customer_id AS INT),
    TRIM(telecom_partner),
    TRIM(gender),
    CAST(age AS TINYINT),
    TRIM(state),
    TRIM(city),
    CAST(pincode AS VARCHAR(10)),
    CAST(date_of_registration AS DATE),
    CAST(num_dependents AS TINYINT),
    CAST(estimated_salary AS DECIMAL(12,2)),

    CASE
        WHEN calls_made < 0 THEN NULL
        ELSE calls_made
    END,
    CASE
        WHEN sms_sent < 0 THEN NULL
        ELSE sms_sent
    END,
    CASE
        WHEN data_used < 0 THEN NULL
        ELSE data_used
    END,
    CAST(churn AS BIT)
FROM telco_raw