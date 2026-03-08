# views 

-- 1  vw_mission_summary  — Core flat table for most visuals

CREATE VIEW vw_mission_summary AS
SELECT
  mission_id, mission_name, launch_date, launch_year, decade,
  country_group, country, agency,
  launch_vehicle, rocket_family, launch_site,
  mission_type, orbit_class, satellite_mass_kg,
  mission_outcome, spacecraft_status,
  estimated_cost_usd_m, fuel_type, operational_life_years,
  notes, dataset_source
FROM missions_clean
WHERE launch_year BETWEEN 1957 AND 2025;

-- 2  vw_country_performance  — Country KPIs

CREATE  VIEW vw_country_performance AS
SELECT
  country_group,
  COUNT(*)                                               AS total_missions,
  SUM(mission_outcome='Success')                         AS successes,
  SUM(mission_outcome='Failure')                         AS failures,
  SUM(mission_outcome='Partial')                         AS partials,
  ROUND(100.0*SUM(mission_outcome='Success')/COUNT(*),2) AS success_rate_pct,
  MIN(launch_year)                                       AS first_launch,
  MAX(launch_year)                                       AS latest_launch,
  COUNT(DISTINCT mission_type)                           AS type_diversity,
  ROUND(AVG(estimated_cost_usd_m),1)                    AS avg_cost_usd_m,
  ROUND(AVG(satellite_mass_kg),0)                        AS avg_mass_kg
FROM missions_clean
GROUP BY country_group;

-- 3  vw_yearly_trends  — Time-series data

CREATE VIEW vw_yearly_trends AS
SELECT
  launch_year, decade, country_group,
  COUNT(*)                                               AS total_missions,
  SUM(mission_outcome='Success')                         AS successes,
  SUM(mission_outcome='Failure')                         AS failures,
  ROUND(100.0*SUM(mission_outcome='Success')/COUNT(*),1) AS success_pct,
  COUNT(DISTINCT mission_type)                           AS types_launched
FROM missions_clean
WHERE launch_year BETWEEN 1957 AND 2025
GROUP BY launch_year, decade, country_group;

-- 4  vw_rocket_reliability  — Launch vehicle analysis

CREATE VIEW vw_rocket_reliability AS
SELECT
  launch_vehicle, rocket_family, country_group,
  COUNT(*)                                               AS total_launches,
  SUM(mission_outcome='Success')                         AS successes,
  SUM(mission_outcome='Failure')                         AS failures,
  ROUND(100.0*SUM(mission_outcome='Success')/COUNT(*),1) AS reliability_pct,
  MIN(launch_year)                                       AS first_flight,
  MAX(launch_year)                                       AS last_flight,
  ROUND(AVG(satellite_mass_kg),0)                        AS avg_payload_kg
FROM missions_clean
GROUP BY launch_vehicle, rocket_family, country_group
HAVING total_launches >= 3;

-- 5  vw_orbit_analysis  — Orbital distribution

CREATE VIEW vw_orbit_analysis AS
SELECT
  orbit_class, country_group, decade,
  COUNT(*)                                               AS mission_count,
  ROUND(AVG(satellite_mass_kg),0)                        AS avg_mass_kg,
  ROUND(100.0*SUM(mission_outcome='Success')/COUNT(*),1) AS success_pct
FROM missions_clean
WHERE orbit_class NOT IN ('Unknown','Other')
GROUP BY orbit_class, country_group, decade;

-- 6  vw_launch_site_map  — Geographic data

CREATE VIEW vw_launch_site_map AS
SELECT
  launch_site, country_group,
  COUNT(*)                                               AS total_launches,
  ROUND(100.0*SUM(mission_outcome='Success')/COUNT(*),1) AS success_pct,
  MIN(launch_year)                                       AS first_launch,
  MAX(launch_year)                                       AS last_launch
FROM missions_clean
WHERE launch_site IS NOT NULL
GROUP BY launch_site, country_group
ORDER BY total_launches DESC;

-- 7  vw_technology_evolution  — Fuel & propulsion trends

CREATE OR REPLACE VIEW  vw_technology_evolution AS
SELECT
  decade, fuel_type, mission_type, country_group,
  COUNT(*)                                               AS missions,
  ROUND(AVG(estimated_cost_usd_m),0)                    AS avg_cost_usd_m
FROM missions_clean
WHERE fuel_type != ''
GROUP BY decade, fuel_type, mission_type, country_group;

-- Check how many rows the view actually returns
SELECT COUNT(*) FROM vw_rocket_reliability;

-- See the data
SELECT launch_vehicle, country_group,
  total_launches, reliability_pct, avg_payload_kg
FROM vw_rocket_reliability
ORDER BY total_launches DESC
LIMIT 10;