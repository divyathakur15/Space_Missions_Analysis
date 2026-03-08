# 📊 Data Directory

This folder contains cleaned and processed datasets of space missions from various space agencies around the world.

## 📁 Files Overview

### Master Dataset
- **`MASTER_CLEANED_FINAL.csv`** - Consolidated dataset containing all space missions from all agencies combined. This is the primary dataset used for comprehensive analysis.

### Country/Agency-Specific Datasets

#### 🇺🇸 United States (NASA)
- **`USA_Space_Missions_CLEANED.csv`** - All NASA and US commercial space missions including Apollo, Space Shuttle, SpaceX, and more.

#### 🇷🇺 Russia/USSR (Roscosmos)
- **`Russia_USSR_Space_Missions_CLEANED.csv`** - Soviet-era and modern Russian space missions including Soyuz, Vostok, and Proton launches.

#### 🇨🇳 China (CNSA)
- **`China_CNSA_Space_Missions_CLEANED.csv`** - Chinese National Space Administration missions including Shenzhou, Chang'e, and Tiangong programs.

#### 🇪🇺 Europe (ESA)
- **`Europe_ESA_Space_Missions_CLEANED.csv`** - European Space Agency missions including Ariane launches and collaborative missions.

#### 🇮🇳 India (ISRO)
- **`India_ISRO_Space_Missions_CLEANED.csv`** - Indian Space Research Organisation missions including PSLV, GSLV, Chandrayaan, and Mangalyaan.

#### 🇯🇵 Japan (JAXA)
- **`Japan_JAXA_Space_Missions_CLEANED.csv`** - Japan Aerospace Exploration Agency missions including H-II rockets and space exploration programs.

#### 🌍 Other Countries
- **`Other_Countries_Space_Missions_CLEANED.csv`** - Space missions from other countries including Israel, Iran, North Korea, and private space companies.

### Additional Files
- **`files.zip`** - Archive containing raw or additional data files (if needed for reference).

## 📋 Data Structure

Each CSV file typically contains the following columns:
- **Mission Name/ID** - Identifier for the space mission
- **Launch Date** - Date and time of launch
- **Launch Site** - Location where the mission was launched
- **Rocket/Vehicle** - Type of rocket or launch vehicle used
- **Mission Type** - Classification (e.g., satellite, crewed, probe)
- **Orbit Type** - Target orbit (LEO, GEO, interplanetary, etc.)
- **Mission Status** - Success/Failure status
- **Payload** - Description of what was launched
- **Agency** - Space agency responsible for the mission
- **Country** - Country of origin

## 🔄 Data Cleaning Process

All datasets have been cleaned and standardized using SQL scripts found in the `sql/` folder:
1. Removed duplicates
2. Standardized date formats
3. Normalized mission names and types
4. Filled missing values where appropriate
5. Standardized country and agency names
6. Validated and corrected orbital classifications

## 💡 Usage

To use this data:
1. Import the desired CSV file into your SQL database or analytics tool
2. For comprehensive analysis, use `MASTER_CLEANED_FINAL.csv`
3. For country-specific insights, use individual agency files
4. Refer to the SQL scripts in `/sql` folder for data processing examples

## 📊 Data Statistics

- **Total Missions**: Thousands of space missions from 1957 to present
- **Countries Covered**: 7+ major space-faring nations
- **Time Period**: From Sputnik 1 (1957) to recent missions
- **Mission Types**: Satellite launches, crewed missions, planetary probes, ISS resupply, and more

## 🔗 Related Files

- See `/sql` folder for data cleaning and analysis scripts
- See `/dashboards` folder for Power BI visualizations
- See main README.md for complete project documentation

---

**Note**: All data has been cleaned and is ready for analysis. For raw data sources or additional information, please refer to the original space agency databases.
