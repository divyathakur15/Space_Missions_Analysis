use space_missions_db;
select * from missions_clean;

# EDA- EXPLORATORY DATA ANALYSIS

-- 1.Dataset Health Check
SELECT
  COUNT(*)                              AS total_records,
  COUNT(DISTINCT country_group)         AS country_groups,
  COUNT(DISTINCT mission_type)          AS mission_types,
  COUNT(DISTINCT orbit_class)           AS orbit_classes,
  COUNT(DISTINCT launch_vehicle)        AS unique_rockets,
  COUNT(DISTINCT launch_site)           AS launch_sites,
  MIN(launch_year)                      AS earliest_year,
  MAX(launch_year)                      AS latest_year,
  ROUND(100.0*SUM(mission_outcome='Success')/COUNT(*),1) AS success_pct,
  SUM(satellite_mass_kg IS NOT NULL)    AS rows_with_mass,
  SUM(estimated_cost_usd_m IS NOT NULL) AS rows_with_cost
FROM missions_clean;


-- 2. Launch Activity Over Time

-- Missions per year with success rate
SELECT
  launch_year,
  decade,
  COUNT(*)                                                   AS total,
  SUM(mission_outcome = 'Success')                           AS successes,
  SUM(mission_outcome = 'Failure')                           AS failures,
  ROUND(100.0*SUM(mission_outcome='Success')/COUNT(*),1)     AS success_pct
FROM missions_clean
WHERE launch_year BETWEEN 1957 AND 2025
GROUP BY launch_year, decade
ORDER BY launch_year;

-- Missions per decade (for bar chart)
SELECT decade, COUNT(*) AS missions,
  COUNT(DISTINCT country_group) AS active_countries
FROM missions_clean
WHERE decade IS NOT NULL
GROUP BY decade ORDER BY decade;



-- 3. Country & Agency Performance
SELECT
  country_group,
  COUNT(*)                                                     AS total,
  SUM(mission_outcome='Success')                               AS successes,
  SUM(mission_outcome='Failure')                               AS failures,
  ROUND(100.0*SUM(mission_outcome='Success')/COUNT(*),1)       AS success_pct,
  MIN(launch_year)                                             AS first_launch,
  MAX(launch_year)                                             AS last_launch,
  COUNT(DISTINCT mission_type)                                 AS type_diversity
FROM missions_clean
GROUP BY country_group
ORDER BY total DESC;

-- Top 15 agencies
SELECT agency, country_group, COUNT(*) AS missions,
  ROUND(100.0*SUM(mission_outcome='Success')/COUNT(*),1) AS success_pct
FROM missions_clean
GROUP BY agency, country_group
ORDER BY missions DESC LIMIT 15;


-- 4.Mission Type & Orbit Distribution

-- Mission type breakdown (pre-normalised)
SELECT mission_type,
  COUNT(*) AS total,
  ROUND(100.0*COUNT(*)/SUM(COUNT(*)) OVER(),1) AS pct
FROM missions_clean
GROUP BY mission_type ORDER BY total DESC;

-- Orbit class distribution
SELECT orbit_class,
  COUNT(*) AS missions,
  ROUND(AVG(satellite_mass_kg),0) AS avg_mass_kg,
  ROUND(100.0*SUM(mission_outcome='Success')/COUNT(*),1) AS success_pct
FROM missions_clean WHERE orbit_class != 'Unknown'
GROUP BY orbit_class ORDER BY missions DESC;

-- 5. Success Rate Analysis
-- Success by country × decade (matrix data)
SELECT country_group, decade,
  COUNT(*) AS missions,
  ROUND(100.0*SUM(mission_outcome='Success')/COUNT(*),1) AS success_pct
FROM missions_clean
WHERE decade IS NOT NULL
GROUP BY country_group, decade ORDER BY country_group, decade;

-- Launch vehicle reliability (min 5 launches)
SELECT launch_vehicle, rocket_family, country_group,
  COUNT(*) AS launches,
  SUM(mission_outcome='Success')  AS successes,
  ROUND(100.0*SUM(mission_outcome='Success')/COUNT(*),1) AS reliability_pct,
  MIN(launch_year) AS first_flight, MAX(launch_year) AS last_flight
FROM missions_clean
GROUP BY launch_vehicle, rocket_family, country_group
HAVING launches >= 5
ORDER BY reliability_pct DESC, launches DESC;


-- 6  Cost & Payload Analysis
-- Average cost by country (32% of records have cost data)
SELECT country_group,
  COUNT(estimated_cost_usd_m)         AS records_with_cost,
  ROUND(AVG(estimated_cost_usd_m),0)  AS avg_cost_usd_m,
  ROUND(MIN(estimated_cost_usd_m),0)  AS min_cost,
  ROUND(MAX(estimated_cost_usd_m),0)  AS max_cost
FROM missions_clean
WHERE estimated_cost_usd_m IS NOT NULL
GROUP BY country_group ORDER BY avg_cost_usd_m DESC;

-- Payload mass trend over decades
SELECT decade,
  COUNT(satellite_mass_kg)            AS records_with_mass,
  ROUND(AVG(satellite_mass_kg),0)     AS avg_mass_kg,
  ROUND(MAX(satellite_mass_kg),0)     AS max_mass_kg
FROM missions_clean
WHERE satellite_mass_kg IS NOT NULL AND decade IS NOT NULL
GROUP BY decade ORDER BY decade;


-- 7  Propulsion Technology Evolution

-- Fuel type usage by decade (technology evolution chart)
SELECT decade, fuel_type, COUNT(*) AS missions
FROM missions_clean
WHERE fuel_type IS NOT NULL AND decade IS NOT NULL
GROUP BY decade, fuel_type
ORDER BY decade, missions DESC;

-- Spacecraft status breakdown
SELECT spacecraft_status, COUNT(*) AS count,
  ROUND(100.0*COUNT(*)/SUM(COUNT(*)) OVER(),1) AS pct
FROM missions_clean
WHERE spacecraft_status IS NOT NULL
GROUP BY spacecraft_status ORDER BY count DESC;


