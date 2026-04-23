use hospital_analytics;

# buisness question 1
# There are "Hidden Gem" hospitals that have a 5-star rating but cost less than the national average.
SELECT 
    h.hospital_name,
    r.drg_description,
    h.rating AS star_rating,
    b.avg_total_payment AS hospital_price,
    round(avg_table.national_avg, 2) AS national_avg_price,
    round(avg_table.national_avg - b.avg_total_payment, 2) AS total_savings,
	l.city,
    l.state
FROM hospitals h
JOIN billing b ON h.facility_id = b.facility_id
JOIN locations l ON h.location_id = l.location_id
JOIN ref_drg r ON b.drg_code = r.drg_code
JOIN (
    SELECT drg_code, AVG(avg_total_payment) AS national_avg
    FROM billing
    GROUP BY drg_code
) AS avg_table ON b.drg_code = avg_table.drg_code
WHERE h.rating = 5 
  AND b.avg_total_payment < avg_table.national_avg
ORDER BY drg_description, b.avg_total_payment ASC;

# Buisness Question 2 State-Level Price Comparison for specific Surgery
# What is the average total payment for a specific surgery (e.g., Hip Replacement - DRG 470) in Texas versus California?
WITH CTE_TOP_STATES AS (
    SELECT 
        l.state_full_name AS state,
        r.drg_description,
        round(AVG(b.avg_total_payment),2) AS avg_total_payment,
        'High Cost' AS category
    FROM billing b
    JOIN hospitals h ON b.facility_id = h.facility_id
    JOIN locations l ON h.location_id = l.location_id
    JOIN ref_drg r ON b.drg_code = r.drg_code
    WHERE b.drg_code = '470'
    GROUP BY l.state_full_name
    ORDER BY avg_total_payment DESC
    LIMIT 5
),
CTE_BOTTOM_STATES AS (
    SELECT 
        l.state_full_name AS state,
         r.drg_description,
        round(AVG(b.avg_total_payment),2) AS avg_total_payment,
        'Low Cost' AS category
    FROM billing b
    JOIN hospitals h ON b.facility_id = h.facility_id
    JOIN locations l ON h.location_id = l.location_id
	JOIN ref_drg r ON b.drg_code = r.drg_code
    WHERE b.drg_code = '470'
    GROUP BY l.state_full_name
    ORDER BY avg_total_payment ASC
    LIMIT 5
)

SELECT * FROM CTE_TOP_STATES
UNION ALL
SELECT * FROM CTE_BOTTOM_STATES;
    
    
SELECT 
    h.hospital_name,
    r.drg_description,
    h.rating AS star_rating,
    b.avg_total_payment AS hospital_price,
    round(avg_table.national_avg, 2) AS national_avg_price,
    round(avg_table.national_avg - b.avg_total_payment, 2) AS total_savings,
	l.city,
    l.state
FROM hospitals h
JOIN billing b ON h.facility_id = b.facility_id
JOIN locations l ON h.location_id = l.location_id
JOIN ref_drg r ON b.drg_code = r.drg_code
JOIN (
    SELECT drg_code, AVG(avg_total_payment) AS national_avg
    FROM billing
    GROUP BY drg_code
) AS avg_table ON b.drg_code = avg_table.drg_code
WHERE h.rating = 5 
  AND b.avg_total_payment < avg_table.national_avg
ORDER BY drg_description, b.avg_total_payment ASC;

# Buisness Question 2 State-Level Price Comparison for specific Surgery
# What is the average total payment for a specific surgery (e.g., Hip Replacement - DRG 470) in Texas versus California?
WITH CTE_TOP_STATES AS (
    SELECT 
        l.state_full_name AS state,
        AVG(b.avg_total_payment) AS avg_total_payment,
        'HIGH' AS top_category
    FROM billing b
    JOIN hospitals h ON b.facility_id = h.facility_id
    JOIN locations l ON h.location_id = l.location_id
    WHERE b.drg_code = '470'
    GROUP BY l.state_full_name
    ORDER BY avg_total_payment DESC
    LIMIT 5
),
CTE_BOTTOM_STATES AS (
    SELECT 
        l.state_full_name AS state,
        AVG(b.avg_total_payment) AS avg_total_payment,
        'LOW' AS bottom_category
    FROM billing b
    JOIN hospitals h ON b.facility_id = h.facility_id
    JOIN locations l ON h.location_id = l.location_id
    WHERE b.drg_code = '470'
    GROUP BY l.state_full_name
    ORDER BY avg_total_payment ASC
    LIMIT 5
)

SELECT * FROM CTE_TOP_STATES
UNION ALL
SELECT * FROM CTE_BOTTOM_STATES;

# Buisness Question 3 Identifying "Revenue Outliers"
SELECT 
    h.hospital_name,
    -- Average of the percentage gap for each procedure
    concat(round((AVG((b.avg_submitted_charges - b.avg_total_payment) / b.avg_submitted_charges) * 100),2), '%') AS avg_price_inflation_pct,
    -- The inverse: What they actually keep
    concat(round((AVG(b.avg_total_payment / b.avg_submitted_charges) * 100) , 2) ,'%') AS avg_collection_rate_pct
FROM 
    billing b
JOIN 
    hospitals h ON b.facility_id = h.facility_id
GROUP BY 
    h.facility_id, h.hospital_name
ORDER BY 
    avg_price_inflation_pct DESC
LIMIT 10;

WITH HospitalAverages AS (
    SELECT 
        facility_id,
        -- Calculate the average write-off % for each hospital first
        AVG((avg_submitted_charges - avg_total_payment) / avg_submitted_charges) * 100 AS avg_writeoff_pct
    FROM billing
    GROUP BY facility_id
)
SELECT 
    CASE 
        WHEN avg_writeoff_pct <= 25 THEN '0-25% (Low Gap)'
        WHEN avg_writeoff_pct <= 50 THEN '26-50% (Moderate Gap)'
        WHEN avg_writeoff_pct <= 75 THEN '51-75% (High Gap)'
        WHEN avg_writeoff_pct <= 90 THEN '76-90% (Very High Gap)'
        ELSE '91-100% (Extreme Outliers)'
    END AS gap_range,
    COUNT(*) AS number_of_hospitals
FROM HospitalAverages
GROUP BY gap_range
ORDER BY gap_range;


SELECT 
    h.hospital_name,
    b.drg_code,
    b.avg_submitted_charges AS asked_amount,
    b.avg_total_payment AS got_amount,
    -- The Calculated Column: The Billing Gap
    (b.avg_submitted_charges - b.avg_total_payment) AS billing_gap,
    -- Collection Percentage (How much of the "Ask" they actually keep)
    ROUND((b.avg_total_payment / b.avg_submitted_charges) * 100, 2) AS collection_rate_pct
FROM 
    billing b
JOIN 
    hospitals h ON b.facility_id = h.facility_id
ORDER BY 
    billing_gap DESC;


SELECT
	facility_id,
    drg_code,
    avg_medicare_payment,
    avg_total_payment,
    round((avg_medicare_payment - avg_total_payment), 2) AS Medicare_Profit_Loss
FROM billing;

SELECT
    facility_id,
    round(SUM(avg_medicare_payment - avg_total_payment), 2) AS total_profit
FROM billing
GROUP BY facility_id;

###Join Hospital
SELECT
    h.hospital_name,
    h.facility_id,
    round(SUM(b.avg_medicare_payment - b.avg_total_payment), 2 ) AS total_profit
FROM billing b
JOIN hospitals h
    ON b.facility_id = h.facility_id
GROUP BY h.facility_id, h.hospital_name;

##Sort highest first, top 10
SELECT
	h.hospital_name,
    h.facility_id,
    round(sum(b.avg_medicare_payment - b.avg_total_payment)) AS total_profit_loss
FROM billing b
JOIN hospitals h
	ON b.facility_id = h.facility_id
GROUP BY h.facility_id, h.hospital_name
ORDER BY total_profit_loss
LIMIT 10;


WITH avg_drg_billing AS (
	SELECT 
    drg_code,
    AVG(avg_total_payment) AS avg_payment
    FROM billing
    GROUP BY drg_code
)
SELECT 
    h.hospital_name,
	r.drg_description,
	h.rating AS star_rating,
	b.avg_total_payment AS hospital_price,
	round(avg_drg_billing.avg_payment, 2) AS national_avg_price,
    round(avg_drg_billing.avg_payment - b.avg_total_payment, 2) AS total_savings,
	l.city, l.state,
    l.state_full_name
    
FROM hospitals h
LEFT JOIN billing b ON h.facility_id = b.facility_id
LEFT JOIN locations l ON h.location_id = l.location_id
LEFT JOIN ref_drg r ON b.drg_code = r.drg_code
LEFT JOIN avg_drg_billing ON b.drg_code = avg_drg_billing.drg_code
WHERE 
	h.rating = 5
  AND 
	b.avg_total_payment < avg_drg_billing.avg_payment
ORDER BY r.drg_code,total_savings DESC;

SELECT
	h.hospital_name, l.state,
    b.avg_submitted_charges, b.avg_total_payment, b.avg_medicare_payment,
	round((b.avg_total_payment/ b.avg_submitted_charges) *100, 2) AS Received_Percentage,
    round((b.avg_submitted_charges - b.avg_total_payment), 2) AS Not_Rocovered,
    round((b.avg_total_payment - b.avg_medicare_payment), 2) AS Non_Medicare_Payment,
	round((b.avg_medicare_payment / b.avg_total_payment), 2 ) AS Percentage_Payment_Med_payment_total_payment

FROM billing b
join hospitals h
	ON b.facility_id = h.facility_id
join locations l
	ON l.location_id = h.location_id
order by h.hospital_name;


SELECT
	h.hospital_name, b.drg_code,
    round((b.avg_submitted_charges - b.avg_total_payment), 2) AS charge_payment_gap,
	b.avg_total_payment,
	round((b.avg_total_payment/ b.avg_submitted_charges) *100, 2) AS Received_Percentage,
    b.avg_medicare_payment,
    round((b.avg_medicare_payment / b.avg_total_payment) * 100, 2 ) AS medicare_contribution_pct,
    round((b.avg_total_payment - b.avg_medicare_payment), 2) AS Non_Medicare_Payment
FROM billing b
join hospitals h
	ON b.facility_id = h.facility_id
join locations l
	ON l.location_id = h.location_id
order by hospital_name;
