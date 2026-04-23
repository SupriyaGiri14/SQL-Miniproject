USE hospital_db;

ALTER TABLE locations; 
ALTER TABLE hospitals; 
ALTER TABLE ref_drg; 
ALTER TABLE billing;

ALTER TABLE locations MODIFY location_id INT NOT NULL;
ALTER TABLE hospitals MODIFY location_id INT;
ALTER TABLE hospitals MODIFY facility_id VARCHAR(50) NOT NULL;
ALTER TABLE ref_drg MODIFY drg_code VARCHAR(50) NOT NULL;

ALTER TABLE billing MODIFY facility_id VARCHAR(50) NOT NULL;
ALTER TABLE billing MODIFY drg_code VARCHAR(50);

ALTER TABLE billing 
ADD CONSTRAINT fk_billing_drg_code_ref_drg 
FOREIGN KEY (drg_code) REFERENCES ref_drg(drg_code);