CREATE DATABASE  space_missions_db;
USE space_missions_db;

-- Raw staging table: every column is VARCHAR so import never fails
CREATE TABLE IF NOT EXISTS missions_raw (
  mission_name            VARCHAR(300),
  launch_date             VARCHAR(20),
  launch_year             VARCHAR(10),
  decade                  VARCHAR(10),
  country_group           VARCHAR(50),
  country                 VARCHAR(100),
  agency                  VARCHAR(200),
  launch_vehicle          VARCHAR(200),
  rocket_family           VARCHAR(100),
  launch_site             VARCHAR(300),
  launch_complex          VARCHAR(200),
  mission_type            VARCHAR(100),
  orbit_class             VARCHAR(50),
  satellite_mass_kg       VARCHAR(20),
  mission_outcome         VARCHAR(30),
  spacecraft_status       VARCHAR(30),
  estimated_cost_usd_m    VARCHAR(20),
  fuel_type               VARCHAR(30),
  operational_life_years  VARCHAR(20),
  notes                   TEXT,
  launch_id               VARCHAR(100),
  data_source             VARCHAR(100),
  dataset_source          VARCHAR(30)
) ;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/MASTER_CLEANED_FINAL.csv'
INTO TABLE missions_raw
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from missions_raw;

CREATE TABLE missions_clean (
  mission_id              INT AUTO_INCREMENT PRIMARY KEY,
  mission_name            VARCHAR(300),
  launch_date             DATE,
  launch_year             SMALLINT,
  decade                  VARCHAR(10),
  country_group           VARCHAR(50),
  country                 VARCHAR(100),
  agency                  VARCHAR(200),
  launch_vehicle          VARCHAR(200),
  rocket_family           VARCHAR(100),
  launch_site             VARCHAR(300),
  launch_complex          VARCHAR(200),
  mission_type            VARCHAR(100),
  orbit_class             VARCHAR(50),
  satellite_mass_kg       DECIMAL(10,2),
  mission_outcome         VARCHAR(30),
  spacecraft_status       VARCHAR(30),
  estimated_cost_usd_m    DECIMAL(10,2),
  fuel_type               VARCHAR(30),
  operational_life_years  DECIMAL(6,2),
  notes                   TEXT,
  launch_id               VARCHAR(100),
  data_source             VARCHAR(100),
  dataset_source          VARCHAR(30)
);


select launch_date , str_to_date(launch_date,"%Y-%m-%d") as converted_date
from missions_raw;

select count(*) as total_rows, count(str_to_date(launch_date,"%Y-%m-%d") ) as will_succeed,
sum(str_to_date(launch_date,"%Y-%m-%d") is NULL ) as will_null
from missions_raw;

select mission_name,country, (str_to_date(launch_date,"%Y-%m-%d")) as converted_null_date
from missions_raw where (str_to_date(launch_date,"%Y-%m-%d" ))is null ;

Alter Table missions_raw
Add column launch_date_clean date after launch_date;

update missions_raw
set launch_date_clean=str_to_date(launch_date,"%Y-%m-%d");

show variables like "%safe%";
set sql_safe_updates =0;

select mission_name, launch_date,launch_year,country_group,mission_type 
from missions_raw
where str_to_date(launch_date,"%Y-%m-%d") is null and launch_date is not null;


-- Type 1: Range dates like "2023-2025"
SELECT mission_name, launch_date 
FROM missions_raw
WHERE launch_date LIKE '%-%' 
  AND STR_TO_DATE(launch_date, '%Y-%m-%d') IS NULL;

-- Type 2: Planned/future like "2026 (planned)" or "2029 planned"  
SELECT mission_name, launch_date
FROM missions_raw
WHERE launch_date LIKE '%planned%'
   OR launch_date LIKE '%Planned%';

-- Type 3: Text mixed in like "2020 (started)" or "12/5/2020 (started)"
SELECT mission_name, launch_date
FROM missions_raw
WHERE launch_date LIKE '%(%)%'
  AND STR_TO_DATE(launch_date, '%Y-%m-%d') IS NULL;
  
  
-- Preview the fix first — always preview before updating
select 
mission_name ,
launch_date               as original,
left(launch_date,4)       as year_extracted,
makedate(left(launch_date,4),1)   as   date_we_will_set
from missions_raw
where launch_date like"%-%"
and str_to_date(launch_date,"%Y-%m-%d") is null 
and launch_date not like "%(%)%";

update missions_raw 
set launch_date_clean = makedate(left(launch_date,4),1)
where launch_date like "%-%"
and str_to_date(launch_date,"%Y-%m-%d") is null;

UPDATE missions_raw
SET launch_date_clean = MAKEDATE(LEFT(launch_date, 4), 1)
WHERE mission_name IN (
  SELECT mission_name FROM (
    SELECT mission_name FROM missions_raw
    WHERE launch_date LIKE '20%-%'
      AND STR_TO_DATE(launch_date, '%Y-%m-%d') IS NULL
  ) AS safe_rows
);







-- Preview the fix
SELECT
  mission_name,
  launch_date                              AS original,
  SUBSTRING(launch_date, 1, 4)             AS year_extracted,
  MAKEDATE(SUBSTRING(launch_date,1,4),1) AS date_we_will_set
FROM missions_raw
WHERE (launch_date LIKE '%planned%'
    OR launch_date LIKE '%Planned%')
  AND STR_TO_DATE(launch_date, '%Y-%m-%d') IS NULL;
  
-- Fix Type 2: "2026 (planned)", "2029 planned"
UPDATE missions_raw
SET launch_date_clean = MAKEDATE(SUBSTRING(launch_date, 1, 4), 1)
WHERE (launch_date LIKE '%planned%' OR launch_date LIKE '%Planned%')
  AND STR_TO_DATE(launch_date, '%Y-%m-%d') IS NULL;
  
  
  
  -- Run this FIRST before anything else
SELECT 
  mission_name,
  launch_date,
  LEFT(launch_date, 4)          AS left4_chars,
  LENGTH(launch_date)           AS total_length,
  ASCII(LEFT(launch_date, 1))   AS first_char_ascii
FROM missions_raw
WHERE STR_TO_DATE(launch_date, '%Y-%m-%d') IS NULL
  AND launch_date IS NOT NULL;
  
-- Test MAKEDATE directly on each value one by one
SELECT MAKEDATE(2023, 1);
SELECT MAKEDATE(2026, 1);
SELECT MAKEDATE('2023', 1);
SELECT MAKEDATE(LEFT('2023-2025', 4), 1);


UPDATE missions_raw
SET launch_date_clean = MAKEDATE(LEFT(launch_date, 4), 1)
WHERE mission_name IN (
  'Guowang constellation (GW)',
  'Qianfan/SpaceSail',
  'DMC (Disaster Monitoring Constellation)'
);
UPDATE missions_raw
SET launch_date_clean = MAKEDATE(LEFT(launch_date, 4), 1)
WHERE mission_name IN (
  'Ariel',
  'MMX (Martian Moon eXploration)'
);

-- '12/5/2020 (started)' → take 4 chars from position 7
UPDATE missions_raw
SET launch_date_clean = MAKEDATE(SUBSTRING(launch_date, 7, 4), 1)
WHERE mission_name = 'Hayabusa 2# (Extended Mission)';


-- '7/16 & 8/9/2000' → take last 4 chars
UPDATE missions_raw
SET launch_date_clean = MAKEDATE(RIGHT(launch_date, 4), 1)
WHERE mission_name = 'Cluster (4 satellites)';


SELECT mission_name, launch_date AS original, launch_date_clean AS fixed
FROM missions_raw
WHERE mission_name IN (
  'Guowang constellation (GW)',
  'Qianfan/SpaceSail',
  'DMC (Disaster Monitoring Constellation)',
  'Ariel',
  'MMX (Martian Moon eXploration)',
  'Hayabusa 2# (Extended Mission)',
  'Cluster (4 satellites)'
);

-- This is safe now because the 7 bad rows already have launch_date_clean filled
-- So we only touch rows where launch_date_clean is still NULL
UPDATE missions_raw
SET launch_date_clean = STR_TO_DATE(launch_date, '%Y-%m-%d')
WHERE launch_date_clean IS NULL
  AND launch_date IS NOT NULL;

-- Should return 0
SELECT COUNT(*) AS still_null
FROM missions_raw
WHERE launch_date_clean IS NULL
  AND launch_date IS NOT NULL;
  
-- Full health check
SELECT
  COUNT(*)                          AS total_rows,
  COUNT(launch_date_clean)          AS dates_filled,
  SUM(launch_date_clean IS NULL)    AS dates_null,
  MIN(launch_date_clean)            AS earliest,
  MAX(launch_date_clean)            AS latest
FROM missions_raw;



-- STEP 2A: Preview the conversion
SELECT
  launch_year,
  CAST(launch_year AS UNSIGNED) AS converted_year
FROM missions_raw
LIMIT 10;

-- STEP 2B: Check for any problem values
SELECT DISTINCT launch_year
FROM missions_raw
WHERE CAST(launch_year AS UNSIGNED) = 0
   OR launch_year IS NULL;
   
-- STEP 2C: Add the new column
ALTER TABLE missions_raw
  ADD COLUMN launch_year_clean SMALLINT AFTER launch_year;
  
-- STEP 2D: Fill it — NULLIF handles empty strings before CAST runs
UPDATE missions_raw
SET launch_year_clean = CAST(NULLIF(TRIM(launch_year), '') AS UNSIGNED);

-- STEP 2E: Verify with real stats — proves it's now a number
SELECT
  MIN(launch_year_clean)            AS earliest_year,
  MAX(launch_year_clean)            AS latest_year,
  COUNT(DISTINCT launch_year_clean) AS unique_years,
  SUM(launch_year_clean IS NULL)    AS null_count
FROM missions_raw;

select mission_name, country , launch_date,launch_date_clean,decade,launch_year,launch_year_clean 
from missions_raw 
where launch_year_clean is null;

update missions_raw
set launch_year_clean =year(launch_date_clean)
where launch_year_clean is null;

select * from missions_raw;


select launch_year_clean,decade
from missions_raw
where decade in ("");

update missions_raw
set decade="2000s"
where decade in("") and launch_year_clean =2000;

update missions_raw
set decade="2000s"
where decade in("") and launch_year_clean =2000;

update missions_raw
set decade="2020s"
where decade in("") and launch_year_clean =2020;

select count(decade)  from missions_raw
where decade in ("");


-- STEP 3A: Preview
SELECT
  satellite_mass_kg,
  CAST(NULLIF(TRIM(satellite_mass_kg), '') AS DECIMAL(10,2)) AS converted_mass
FROM missions_raw
LIMIT 15;

-- STEP 3B: Spot any values that won't convert cleanly
SELECT DISTINCT satellite_mass_kg
FROM missions_raw
WHERE satellite_mass_kg is not null
  AND CAST(NULLIF(TRIM(satellite_mass_kg), '') AS DECIMAL(10,2)) IS NULL;
  
select * from missions_raw;
  -- STEP 3C: Add column
ALTER TABLE missions_raw
  ADD COLUMN satellite_mass_kg_clean DECIMAL(10,2) AFTER satellite_mass_kg;
  
  -- STEP 3D: Fill it
UPDATE missions_raw
SET satellite_mass_kg_clean = CAST(NULLIF(TRIM(satellite_mass_kg), '') AS DECIMAL(10,2));

-- STEP 3E: Verify with real aggregations — proves it's now a real number
SELECT
  COUNT(satellite_mass_kg_clean)         AS rows_with_mass,
  MIN(satellite_mass_kg_clean)           AS lightest_kg,
  MAX(satellite_mass_kg_clean)           AS heaviest_kg,
  ROUND(AVG(satellite_mass_kg_clean), 0) AS average_kg
FROM missions_raw;

select sum(satellite_mass_kg_clean is null) from missions_raw;


-- STEP 4A: Preview what's in there
SELECT DISTINCT estimated_cost_usd_m
FROM missions_raw
WHERE estimated_cost_usd_m IS NOT NULL
LIMIT 20;

-- STEP 4B: Preview conversion
SELECT
  estimated_cost_usd_m,
  CAST(NULLIF(TRIM(estimated_cost_usd_m), '') AS DECIMAL(10,2)) AS converted_cost
FROM missions_raw
WHERE estimated_cost_usd_m IS NOT NULL
LIMIT 15;

-- STEP 4C: Add column
ALTER TABLE missions_raw
ADD COLUMN estimated_cost_usd_m_clean DECIMAL(10,2) AFTER estimated_cost_usd_m;

-- STEP 4D: Fill it
UPDATE missions_raw
SET estimated_cost_usd_m_clean = CAST(NULLIF(TRIM(estimated_cost_usd_m), '') AS DECIMAL(10,2));

-- STEP 4E: Verify
SELECT
  COUNT(estimated_cost_usd_m_clean)         AS rows_with_cost,
  MIN(estimated_cost_usd_m_clean)           AS cheapest_usd_m,
  MAX(estimated_cost_usd_m_clean)           AS most_expensive_usd_m,
  ROUND(AVG(estimated_cost_usd_m_clean), 0) AS average_cost_usd_m
FROM missions_raw;



# OPERATIONAL LIFE YEARS

-- STEP 5A: Preview
SELECT DISTINCT operational_life_years
FROM missions_raw
WHERE operational_life_years IS NOT NULL
LIMIT 20;

-- STEP 5B: Preview conversion
SELECT
  operational_life_years,
  CAST(NULLIF(TRIM(operational_life_years), '') AS DECIMAL(6,2)) AS converted_life
FROM missions_raw
WHERE operational_life_years IS NOT NULL
LIMIT 15;

-- STEP 5C: Add column
ALTER TABLE missions_raw
  ADD COLUMN operational_life_years_clean DECIMAL(6,2) AFTER operational_life_years;
  
-- STEP 5D: Fill it
UPDATE missions_raw
SET operational_life_years_clean = CAST(NULLIF(TRIM(operational_life_years), '') AS DECIMAL(6,2));

-- STEP 5E: Verify
SELECT
  COUNT(operational_life_years_clean)         AS rows_with_data,
  MIN(operational_life_years_clean)           AS shortest_life,
  MAX(operational_life_years_clean)           AS longest_life,
  ROUND(AVG(operational_life_years_clean), 1) AS average_years
FROM missions_raw;


SELECT
  mission_name,
  launch_date,               launch_date_clean,
  launch_year,               launch_year_clean,
  satellite_mass_kg,         satellite_mass_kg_clean,
  estimated_cost_usd_m,      estimated_cost_usd_m_clean,
  operational_life_years,    operational_life_years_clean
FROM missions_raw
LIMIT 20;

select * from missions_raw;

INSERT INTO missions_clean (
  mission_name, launch_date, launch_year, decade,
  country_group, country, agency,
  launch_vehicle, rocket_family, launch_site, launch_complex,
  mission_type, orbit_class,
  satellite_mass_kg, mission_outcome, spacecraft_status,
  estimated_cost_usd_m, fuel_type, operational_life_years,
  notes, launch_id, data_source, dataset_source
)
SELECT
  mission_name,
  launch_date_clean,
  launch_year_clean,
  decade,
  country_group,
  country,
  agency,
  launch_vehicle,
  rocket_family,
  launch_site,
  launch_complex,
  mission_type,
  orbit_class,
  satellite_mass_kg_clean,
  mission_outcome,
  spacecraft_status,
  estimated_cost_usd_m_clean,
  fuel_type,
  operational_life_years_clean,
  notes,
  launch_id,
  data_source,
  dataset_source
FROM missions_raw;

-- Final check
SELECT * FROM missions_clean;  -- expect 1587


-- Count each type in fuel_type
SELECT
  SUM(fuel_type IS NULL)          AS actual_nulls,
  SUM(fuel_type = '')             AS empty_strings,
  SUM(fuel_type = 'Unknown')      AS says_unknown,
  SUM(fuel_type IS NOT NULL 
      AND fuel_type != '')        AS has_real_value,
  COUNT(*)                        AS total
FROM missions_clean;


-- Same for orbit_class
SELECT
  SUM(orbit_class IS NULL)        AS actual_nulls,
  SUM(orbit_class = '')           AS empty_strings,
  SUM(orbit_class = 'Unknown')    AS says_unknown,
  SUM(orbit_class = 'Other')      AS says_other,
  SUM(orbit_class IS NOT NULL 
      AND orbit_class NOT IN ('Unknown','Other','')) AS has_real_value,
  COUNT(*)                        AS total
FROM missions_clean;

use space_missions_db;

-- First confirm it
SELECT COUNT(*) AS empty_launch_sites
FROM missions_clean
WHERE launch_site = '';

-- See which missions have empty launch site
SELECT mission_name, country_group, launch_year, launch_site
FROM missions_clean
WHERE launch_site is null;

select distinct mission_outcome from missions_clean;


-- First confirm it
SELECT COUNT(*) AS empty_launch_sites
FROM missions_clean
WHERE launch_site = '';

-- See which missions have empty launch site
SELECT mission_name, country_group, launch_year, launch_site
FROM missions_clean
WHERE launch_site = '';

set sql_safe_updates =0;
 
-- Convert empty string to NULL
UPDATE missions_clean
SET launch_site = NULL
WHERE launch_site = '';

select * from vw_technology_evolution
where fuel_type ='';

-- Verify
SELECT COUNT(*) FROM missions_clean WHERE launch_site = '';  -- expect 0
SELECT COUNT(*) FROM missions_clean WHERE launch_site IS NULL;


SELECT fuel_type, SUM(missions) AS total_missions
FROM vw_technology_evolution
GROUP BY fuel_type
ORDER BY total_missions DESC;
