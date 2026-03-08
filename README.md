# 🚀 Space Missions Analysis

A comprehensive data analytics project analyzing global space missions from multiple space agencies including NASA, ESA, ISRO, CNSA, JAXA, and Roscosmos. This project includes end-to-end data cleaning, exploratory data analysis, and interactive Power BI dashboards.

## 📊 Project Overview

This project analyzes historical space mission data to uncover insights about launch success rates, orbital patterns, agency performance, and trends in space exploration across different countries and time periods.

## 🗂️ Project Structure

```
SAPCE ANALYTICS PROJECT/
│
├── DATASET/                          # Raw and cleaned datasets
│   ├── MASTER_CLEANED_FINAL.csv     # Consolidated cleaned dataset
│   ├── USA_Space_Missions_CLEANED.csv
│   ├── Russia_USSR_Space_Missions_CLEANED.csv
│   ├── China_CNSA_Space_Missions_CLEANED.csv
│   ├── Europe_ESA_Space_Missions_CLEANED.csv
│   ├── India_ISRO_Space_Missions_CLEANED.csv
│   ├── Japan_JAXA_Space_Missions_CLEANED.csv
│   └── Other_Countries_Space_Missions_CLEANED.csv
│
├── SQL FILE/                         # SQL scripts for analysis
│   ├── SAPCE ANALYSIS DATA CLEANING.sql
│   ├── SPACE ANALYSIS EDA.sql
│   └── SPACE ANALYSIS VIEWS.sql
│
├── PowerBi Dashboard/                # Power BI dashboard files
│   └── Space Analytics Dashboards.pbix
│
└── DASHBAORD IMAGES/                 # Dashboard screenshots
    ├── Front Page Space Mission Analysis.PNG
    ├── Executive Dashboard.PNG
    ├── Country & Agency Analysis.PNG
    ├── History & Trends Analysis.PNG
    ├── Missions & Orbital Analysis.PNG
    └── Rocket & launch Site Analysis.PNG
```

## 🎯 Key Features

- **Data Cleaning & Preparation**: Comprehensive SQL scripts for data standardization and quality assurance
- **Exploratory Data Analysis**: In-depth analysis of mission success rates, launch patterns, and trends
- **Interactive Dashboards**: Multi-page Power BI dashboards with dynamic filtering and drill-down capabilities
- **Multi-Agency Coverage**: Analysis spanning USA, Russia/USSR, China, Europe, India, Japan, and other countries

## 📈 Dashboard Pages

### 1. Front Page
Landing page with project overview and navigation

### 2. Executive Dashboard
High-level KPIs and summary metrics for quick insights

### 3. Country & Agency Analysis
Comparative analysis of space agencies and their performance

### 4. History & Trends Analysis
Temporal analysis of space missions across decades

### 5. Missions & Orbital Analysis
Deep dive into mission types and orbital characteristics

### 6. Rocket & Launch Site Analysis
Analysis of rocket types and launch facility performance

## 🛠️ Technologies Used

- **Database**: SQL Server / MySQL
- **Data Visualization**: Microsoft Power BI
- **Data Processing**: SQL
- **File Formats**: CSV, PBIX

## 📊 Data Sources

The project analyzes space missions from:
- 🇺🇸 **USA (NASA)**: American space missions
- 🇷🇺 **Russia/USSR (Roscosmos)**: Soviet and Russian missions
- 🇨🇳 **China (CNSA)**: Chinese National Space Administration missions
- 🇪🇺 **Europe (ESA)**: European Space Agency missions
- 🇮🇳 **India (ISRO)**: Indian Space Research Organisation missions
- 🇯🇵 **Japan (JAXA)**: Japan Aerospace Exploration Agency missions
- 🌍 **Other Countries**: Additional international space missions

## 🚀 Getting Started

### Prerequisites
- SQL Server / MySQL database
- Microsoft Power BI Desktop
- Basic understanding of SQL and data visualization

### Setup Instructions

1. **Database Setup**
   - Import the cleaned datasets from the [DATASET](../DATASET) folder
   - Run [SAPCE ANALYSIS DATA CLEANING.sql](../SQL%20FILE/SAPCE%20ANALYSIS%20DATA%20CLEANING.sql) for data preparation
   - Execute [SPACE ANALYSIS VIEWS.sql](../SQL%20FILE/SPACE%20ANALYSIS%20VIEWS.sql) to create necessary views

2. **Exploratory Analysis**
   - Run [SPACE ANALYSIS EDA.sql](../SQL%20FILE/SPACE%20ANALYSIS%20EDA.sql) to generate insights

3. **Dashboard Access**
   - Open [Space Analytics Dashboards.pbix](../PowerBi%20Dashboard/Space%20Analytics%20Dashboards.pbix) in Power BI Desktop
   - Refresh data connections if needed
   - Explore the interactive dashboards

## 📸 Dashboard Previews

View dashboard screenshots in the [DASHBAORD IMAGES](../DASHBAORD%20IMAGES) folder:
- [Front Page](../DASHBAORD%20IMAGES/Front%20Page%20Space%20Mission%20Analysis.PNG)
- [Executive Dashboard](../DASHBAORD%20IMAGES/Executive%20Dashboard.PNG)
- [Country & Agency Analysis](../DASHBAORD%20IMAGES/Country%20&%20Agency%20Analysis.PNG)
- [History & Trends](../DASHBAORD%20IMAGES/History%20&%20Trends%20Analysis.PNG)
- [Missions & Orbital Analysis](../DASHBAORD%20IMAGES/Missions%20&%20Orbital%20Analysis.PNG)
- [Rocket & Launch Site Analysis](../DASHBAORD%20IMAGES/Rocket%20&%20launch%20Site%20Analysis.PNG)

## 📊 Key Insights

- Historical trends in space exploration across decades
- Success rates by country and space agency
- Most utilized launch sites and rocket types
- Orbital distribution patterns
- Mission frequency and seasonal trends

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

## 👤 Author

Your analysis of space missions data 🛸

## 🌟 Acknowledgments

- Data sources from various space agencies
- Power BI community for visualization inspiration

---

**⭐ If you found this project helpful, please consider giving it a star!**