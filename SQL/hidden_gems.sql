USE hospital_db;

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
    l.state_full
FROM hospitals h
LEFT JOIN billing b ON h.facility_id = b.facility_id
LEFT JOIN locations l ON h.location_id = l.location_id
LEFT JOIN ref_drg r ON b.drg_code = r.drg_code
LEFT JOIN avg_drg_billing ON b.drg_code = avg_drg_billing.drg_code
WHERE 
	h.rating = 5 
  AND 
	b.avg_total_payment < avg_drg_billing.avg_payment
ORDER BY l.state_full,total_savings DESC