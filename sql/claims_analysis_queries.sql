-- ============================================================
-- Healthcare Cost Risk Model: SQL Analysis
-- Author: Zhenjie Huang
-- Purpose:
--   Analyze healthcare insurance charges, predicted charges,
--   BMI groups, smoking status, and actuarial-style risk tiers.
-- ============================================================


-- ============================================================
-- 1. Preview Dataset
-- ============================================================

SELECT
    *
FROM insurance
LIMIT 10;


-- ============================================================
-- 2. Dataset Size
-- ============================================================

SELECT
    COUNT(*) AS total_records
FROM insurance;


-- ============================================================
-- 3. Overall Portfolio Summary
-- ============================================================

SELECT
    ROUND(AVG(charges), 2) AS avg_actual_charges,
    ROUND(AVG(predicted_charges), 2) AS avg_predicted_charges,
    ROUND(MIN(charges), 2) AS min_actual_charges,
    ROUND(MAX(charges), 2) AS max_actual_charges
FROM insurance;


-- ============================================================
-- 4. Average Charges by Smoking Status
-- ============================================================

SELECT
    smoker,
    COUNT(*) AS member_count,
    ROUND(AVG(charges), 2) AS avg_actual_charges,
    ROUND(AVG(predicted_charges), 2) AS avg_predicted_charges
FROM insurance
GROUP BY smoker
ORDER BY avg_actual_charges DESC;


-- ============================================================
-- 5. Average Charges by BMI Group and Smoking Status
-- ============================================================

SELECT
    bmi_group,
    smoker,
    COUNT(*) AS member_count,
    ROUND(AVG(charges), 2) AS avg_actual_charges,
    ROUND(AVG(predicted_charges), 2) AS avg_predicted_charges
FROM insurance
GROUP BY bmi_group, smoker
ORDER BY bmi_group, smoker;


-- ============================================================
-- 6. Average Actual vs Predicted Charges by Risk Tier
-- ============================================================

SELECT
    risk_tier,
    COUNT(*) AS member_count,
    ROUND(AVG(charges), 2) AS avg_actual_charges,
    ROUND(AVG(predicted_charges), 2) AS avg_predicted_charges
FROM insurance
GROUP BY risk_tier
ORDER BY avg_predicted_charges ASC;


-- ============================================================
-- 7. Average Prediction Error by Risk Tier
-- ============================================================

SELECT
    risk_tier,
    COUNT(*) AS member_count,
    ROUND(AVG(ABS(charges - predicted_charges)), 2) AS avg_absolute_error,
    ROUND(AVG(ABS(charges - predicted_charges) / charges) * 100, 2) AS avg_absolute_percent_error
FROM insurance
GROUP BY risk_tier
ORDER BY avg_absolute_error DESC;


-- ============================================================
-- 8. Severe Risk Population Breakdown
-- ============================================================

SELECT
    smoker,
    bmi_group,
    COUNT(*) AS member_count,
    ROUND(AVG(charges), 2) AS avg_actual_charges,
    ROUND(AVG(predicted_charges), 2) AS avg_predicted_charges
FROM insurance
WHERE risk_tier = 'Severe Risk'
GROUP BY smoker, bmi_group
ORDER BY avg_actual_charges DESC;


-- ============================================================
-- 9. Top 10 Highest Actual Healthcare Charges
-- ============================================================

SELECT
    age,
    sex,
    bmi,
    bmi_group,
    smoker,
    region,
    charges,
    predicted_charges,
    risk_tier
FROM insurance
ORDER BY charges DESC
LIMIT 10;


-- ============================================================
-- 10. Top 10 Highest Predicted Healthcare Charges
-- ============================================================

SELECT
    age,
    sex,
    bmi,
    bmi_group,
    smoker,
    region,
    charges,
    predicted_charges,
    risk_tier
FROM insurance
ORDER BY predicted_charges DESC
LIMIT 10;


-- ============================================================
-- 11. Average Charges by Age Band
-- ============================================================

SELECT
    CASE
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56+'
    END AS age_band,
    COUNT(*) AS member_count,
    ROUND(AVG(charges), 2) AS avg_actual_charges,
    ROUND(AVG(predicted_charges), 2) AS avg_predicted_charges
FROM insurance
GROUP BY age_band
ORDER BY avg_actual_charges ASC;


-- ============================================================
-- 12. Risk Tier Composition by Smoking Status
-- ============================================================

SELECT
    risk_tier,
    smoker,
    COUNT(*) AS member_count
FROM insurance
GROUP BY risk_tier, smoker
ORDER BY risk_tier, smoker;