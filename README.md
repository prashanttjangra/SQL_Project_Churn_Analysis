# Introduction
This project analyzes customer churn to identify key patterns and factors associated with customer attrition. Using customer demographics, usage behavior, partnership status, salary ranges, and geographic data, the analysis uncovers churn trends and translates them into meaningful business insights.

Check out the queries here: [project_sql](https://github.com/prashanttjangra/SQL_Project_Churn_Analysis/tree/main/project_sql)

# Business Questions
### The analysis was designed to answer the following business questions:
1. What is the overall customer churn rate?
2. How does churn vary based on partnership status?
3. Which usage patterns are associated with higher churn?
4. How does churn vary across different demographic groups?
5. Which age groups have the highest churn rates?
6. How does churn vary across different salary ranges?
7. Which states have higher customer churn?
8. How does churn vary across telecom partners and states?

# Tools Used
- **SQL:** The backbone of my analysis, enabling me to explore the dataset and extract meaningful insights from customer data.
- **Microsoft SQL Server:** The database management system I used to store, clean, and manage the customer churn data.
- **Visual Studio Code:** My go-to environment for writing and running SQL queries while managing the project structure.
- **Git & GitHub:** Essential for version control and showcasing my SQL scripts and analysis.

# The Analysis
## 1. Overall Customer Churn
To analyze the overall customer churn rate, this query calculates the total customer base, churned customers, retained customers, and the overall percentage of customers who have churned.
``` sql
SELECT
    COUNT(*) as total_customers,
    SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) as churned_customers,
    SUM(CASE WHEN churn = 0 THEN 1 ELSE 0 END) as retained_customers,
    CAST(100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5, 2)) AS churn_rate
FROM telco_clean
```
_Here's a breakdown of the overall customer churn identified by the analysis_

- The dataset contains 2,026 total customers, of which 393 have churned.
- The overall churn rate stands at 19.4%, providing a baseline for comparing churn across different customer segments.

## 2. Churn by Telecom Partner
To compare customer churn across telecom partners, this query calculates the customer count, number of churned customers, and churn rate for each partner.
``` sql
SELECT
    telecom_partner,
    COUNT(*) as total_customers,
    SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) as churned_customers,
    CAST(100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5, 2)) AS churn_rate
FROM telco_clean
GROUP BY telecom_partner
ORDER BY churn_rate DESC
```
_Here's a breakdown of churn performance across partners_

- Vodafone records the highest churn rate at 21%, while Airtel has the lowest at 17%.
- The differences in churn rates highlight variations in customer retention across telecom partners.

## 3. Customer Usage Behaviour
To understand how customer usage differs between churned and retained customers, this query compares average calls made, SMS sent, data usage, and estimated salary across both groups.
``` sql
SELECT
    churn,
    COUNT(*) AS customers,
    CAST(AVG(calls_made) AS DECIMAL(5, 2)) AS avg_calls,
    CAST(AVG(sms_sent) AS DECIMAL(5, 2)) AS avg_sms,
    CAST(AVG(data_used) AS DECIMAL(10, 2)) AS avg_data,
    CAST(AVG(estimated_salary) AS DECIMAL(10, 2)) AS avg_salary
FROM telco_clean
GROUP BY churn
```
_Here's a breakdown of customer usage behaviour by churn status_

- Churned and retained customers show differences in average calls, SMS usage, and data consumption.
- The comparison helps identify usage patterns that may be associated with higher customer churn.

## 4. Demographic Churn by Gender
To examine churn across customer demographics, this query compares the number of customers, churned customers, and churn rates by gender.
``` sql
SELECT
    gender,
    COUNT(*) AS customers,
    SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
    CAST(100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS churn_rate
FROM telco_clean
GROUP BY gender
ORDER BY churn_rate DESC
```
_Here's a breakdown of customer churn across gender groups_

- Female customers have a churn rate of 20.30%, compared to 18.81% for male customers.
- The results provide a demographic-level view of customer churn and help identify differences between customer groups.

## 5. Churn by Age Group
To understand how customer age relates to churn, this query segments customers into age groups and calculates the churn rate for each segment.
``` sql
SELECT
    CASE
        WHEN age < 25 THEN '18-24'
        WHEN age < 35 THEN '25-34'
        WHEN age < 45 THEN '35-44'
        WHEN age < 55 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    COUNT(*) AS customers,
    SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
    CAST(100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS churn_rate
FROM telco_clean
GROUP BY
    CASE
        WHEN age < 25 THEN '18-24'
        WHEN age < 35 THEN '25-34'
        WHEN age < 45 THEN '35-44'
        WHEN age < 55 THEN '45-54'
        ELSE '55+'
    END
ORDER BY churn_rate DESC
```
_Here's a breakdown of churn across different age groups_

- The 35-44 segment has the highest churn rate at 20.71%.
- Churn rates vary across age groups, providing a basis for identifying customer segments that may require closer retention analysis.

## 6. Churn by Salary Range
To examine whether churn patterns vary across income levels, this query segments customers into salary ranges and compares their respective churn rates.
``` sql
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
```
_Here's a breakdown of churn across salary segments_

- The Low salary segment records the highest churn rate at 23.68%.
- Comparing salary segments helps identify whether customer churn varies across different income levels.

## 7. Churn  by State
To identify geographic variations in customer churn, this query calculates customer counts and churn rates across states while applying a minimum sample-size threshold of 30 customers.
``` sql
SELECT
    state,
    COUNT(*) AS customers,
    SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
    CAST(100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS churn_rate
FROM telco_clean
GROUP BY state
HAVING COUNT(*) >= 30
ORDER BY churn_rate DESC
```
_Here's a breakdown of geographic differences in customer churn_

- Bihar records the highest churn rate among states meeting the minimum sample-size requirement.
- Applying a 30-customer threshold helps reduce the risk of misleading churn rates from very small customer groups.

## 8. Churn by Telecom Partner and State
To investigate churn at a more granular level, this query analyzes customer churn by combining telecom partner and state, while applying a minimum sample-size threshold of 20 customers per group.
``` sql
SELECT
    telecom_partner,
    state,
    COUNT(*) AS customers,
    SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
    CAST(100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS churn_rate
FROM telco_clean
GROUP BY telecom_partner, state
HAVING COUNT(*) >= 20
ORDER BY churn_rate DESC
```
_Here's a breakdown of churn across telecom partners and states_

- Combining telecom partner and state reveals more granular differences in customer churn.
- The 20-customer minimum threshold helps reduce the influence of unusually high or low churn rates from very small groups.

# What I Learned
Throughout this project, I strengthened my SQL skills and developed a more business-focused approach to data analysis:

- **Data Aggregation:** Strengthened my use of GROUP BY, COUNT(), SUM(), and AVG() to analyze customer churn and usage patterns.
- **Conditional Analysis:** Improved my use of CASE statements to calculate churn metrics and create meaningful customer segments such as age and salary groups.
- **Data Reliability:** Learned to apply minimum sample-size thresholds when analyzing smaller customer groups to reduce the risk of misleading churn rates.
- **Business Analysis:** Improved my ability to translate business questions into SQL queries and use the results to identify customer churn patterns and potential areas for further analysis.

# Conclusions
## Insights
1. The overall customer churn rate is 19.4%, with 393 out of 2,026 customers having churned, providing a baseline for evaluating churn across different customer segments.
2. Vodafone records the highest churn rate at 21%, while Airtel has the lowest at 17%, indicating differences in customer churn across telecom partners.
3. Female customers have a slightly higher churn rate (20.30%) than male customers (18.81%), showing a small difference in churn across gender groups.
4. The 35–44 age group records the highest churn rate at 20.71%, while churn varies across other age segments, highlighting age as a useful dimension for customer segmentation.
5. The Low salary segment has the highest churn rate at 23.68%, suggesting that churn patterns differ across income groups and may warrant further investigation.
6. Bihar records the highest churn rate among states meeting the 30-customer minimum threshold, highlighting geographic differences in customer churn.
7. Combining telecom partner and state provides a more granular view of churn and can help identify specific customer segments with higher churn rates while the 20-customer threshold reduces the impact of small sample sizes.