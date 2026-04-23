#craete database
DROP DATABASE IF EXISTS hospital_analytics;
CREATE database hospital_analytics;

# use the newly created databse for project
USE hospital_analytics;

# create table hospitals
DROP TABLE IF EXISTS hospitals;
CREATE TABLE hospitals (
    facility_id varchar(10) primary key,
    location_id int,
    hospital_name varchar(255),
    type_of_hospital varchar(50),
    owenership varchar(255),
    address varchar(100),
    emergency_service varchar(3),
    rating varchar(1)
);

# this query is required so that it allows file upload from local storage
SET GLOBAL local_infile = 1;

#populate the table hospitals
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/hospitals.csv'
INTO TABLE hospitals
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

# craete table locations
DROP TABLE IF EXISTS locations;
CREATE TABLE locations (
    location_id int primary key,
    city varchar(50),
    state varchar(5),
    state_full_name varchar(50),
    zip varchar(5),
    county varchar(50),
    country varchar(20)
);

#populate the table locations
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/locations.csv'
INTO TABLE locations
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

# craete table ref_drg
DROP TABLE IF EXISTS ref_drg;
CREATE TABLE ref_drg (
    drg_code int primary key,
    drg_description varchar(400)
);

#populate the table ref_drg
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ref_drg.csv'
INTO TABLE ref_drg
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

# craete table ref_drg
DROP TABLE IF EXISTS billing;
CREATE TABLE billing (
    facility_id varchar(10),
    drg_code int,
    total_discharges smallint,
    avg_submitted_charges float,
    avg_total_payment float,
    avg_medicare_payment float
);

#populate the table billing
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/billing.csv'
INTO TABLE billing
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

# link tables with primary and foreigh keys
# joining billing and ref_drg table
ALTER TABLE billing 
add constraint fk_drg_code
foreign key(drg_code)
references ref_drg(drg_code);

# joining hospitals and locations table
ALTER TABLE hospitals 
add constraint fk_location_id
foreign key(location_id)
references locations(location_id);

# while assigning foreighn key contraints we came to know that some rows in billing table is not there in hospital table
# this is because billing table is from 2023 and hospitals are listed as of todays date(2026)
# so we deleted unmatching rows
SELECT DISTINCT count(*)
FROM billing b
LEFT JOIN hospitals h
ON b.facility_id = h.facility_id
WHERE h.facility_id IS NULL;

SET SQL_SAFE_UPDATES = 0;
DELETE b
FROM billing b
LEFT JOIN hospitals h
ON b.facility_id = h.facility_id
WHERE h.facility_id IS NULL;

# now joining billing and hospitals table
ALTER TABLE billing 
add constraint fk_facility_id
foreign key(facility_id)
references hospitals(facility_id);
use hospital_analytics;

# adding primary key to billing
ALTER TABLE billing
ADD PRIMARY KEY (facility_id, drg_code);

