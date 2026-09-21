CREATE TABLE telco_clean (
    customer_id INT,
    telecom_partner VARCHAR(50),
    gender VARCHAR(20),
    age TINYINT,
    state VARCHAR(50),
    city VARCHAR(50),
    pincode VARCHAR(10),
    date_of_registration DATE,
    num_dependent TINYINT,
    estimated_salary DECIMAL(12,2),
    calls_made INT,
    sms_sent INT,
    data_used DECIMAL(10,2),
    churn BIT
)