USE hospital_db;


SELECT 
    h.hospital_name,
    l.city,
    l.state,
    h.rating AS star_rating,
    r.drg_description,
    b.avg_total_payment AS hospital_price,
    round(avg_table.national_avg, 2) AS national_avg_price,
    round(avg_table.national_avg - b.avg_total_payment, 2) AS total_savings
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
ORDER BY total_savings DESC;