# Buisness Question 2 State-Level Price Comparison for specific Surgery
# What is the average total payment for a specific surgery (e.g., Hip Replacement - DRG 470) in Texas versus California?

use hospital_analytics;

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