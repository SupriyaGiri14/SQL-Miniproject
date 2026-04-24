# Buisness Question 3 Identifying gap between hospital costing and medicare approved cost

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