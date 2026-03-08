# 🛠️ SQL Scripts Directory

This folder contains SQL scripts for data cleaning, exploratory data analysis (EDA), and creating database views for the Space Missions Analysis project.

## 📁 Files Overview

### 1. **SAPCE ANALYSIS DATA CLEANING.sql**
This script handles all data cleaning and preparation tasks.

**Purpose:**
- Import raw space mission data
- Remove duplicates and inconsistencies
- Standardize date formats and mission names
- Handle missing or null values
- Normalize country and agency names
- Validate data types and constraints
- Create cleaned tables ready for analysis

**Key Operations:**
- Data deduplication
- String standardization and trimming
- Date/time format conversion
- NULL value handling
- Data type validation
- Constraint creation

---

### 2. **SPACE ANALYSIS EDA.sql**
Exploratory Data Analysis script for discovering insights and patterns.

**Purpose:**
- Perform statistical analysis on space missions
- Calculate key metrics and KPIs
- Identify trends and patterns over time
- Compare performance across agencies
- Analyze success rates and mission outcomes

**Analyses Included:**
- **Mission Statistics**: Total missions, success rates, failure analysis
- **Temporal Analysis**: Missions by year, decade, seasonal patterns
- **Agency Comparison**: Launches by country, agency performance metrics
- **Rocket Analysis**: Most used rockets, reliability statistics
- **Launch Site Analysis**: Most active launch sites, geographic distribution
- **Orbital Analysis**: Distribution of orbit types (LEO, GEO, etc.)
- **Mission Type Breakdown**: Satellites, crewed missions, probes, etc.
- **Trend Analysis**: Growth trends, technological evolution

---

### 3. **SPACE ANALYSIS VIEWS.sql**
Creates database views for simplified querying and reporting.

**Purpose:**
- Create reusable SQL views for common queries
- Simplify complex joins and aggregations
- Provide clean interfaces for Power BI dashboards
- Enable faster query performance

**Views Created:**
- **Agency Summary View**: Aggregated statistics by space agency
- **Mission Timeline View**: Chronological mission data with key metrics
- **Success Rate View**: Success/failure metrics by various dimensions
- **Launch Site View**: Launch site statistics and utilization
- **Rocket Performance View**: Rocket usage and reliability metrics
- **Orbital Distribution View**: Mission distribution by orbit type
- **Country Statistics View**: Country-level aggregations
- **Yearly Trends View**: Year-over-year mission statistics

---

## 🚀 How to Use These Scripts

### Prerequisites
- SQL Server, MySQL, PostgreSQL, or compatible database
- Database client (SQL Server Management Studio, MySQL Workbench, etc.)
- Import the cleaned CSV files from `/data` folder first

### Execution Order

1. **First: Data Cleaning**
   ```sql
   -- Run SAPCE ANALYSIS DATA CLEANING.sql
   -- This prepares your data for analysis
   ```

2. **Second: Create Views**
   ```sql
   -- Run SPACE ANALYSIS VIEWS.sql
   -- This creates helpful views for querying
   ```

3. **Third: Exploratory Analysis**
   ```sql
   -- Run SPACE ANALYSIS EDA.sql
   -- This generates insights and statistics
   ```

### Running the Scripts

**Option 1: SQL Server Management Studio (SSMS)**
```sql
-- Open each file in SSMS
-- Connect to your database
-- Execute the script (F5 or Execute button)
```

**Option 2: MySQL Workbench**
```sql
-- Open SQL script
-- Connect to MySQL database
-- Execute script (Ctrl+Shift+Enter)
```

**Option 3: Command Line**
```bash
# SQL Server
sqlcmd -S localhost -d SpaceMissions -i "SAPCE ANALYSIS DATA CLEANING.sql"

# MySQL
mysql -u username -p database_name < "SAPCE ANALYSIS DATA CLEANING.sql"

# PostgreSQL
psql -U username -d database_name -f "SAPCE ANALYSIS DATA CLEANING.sql"
```

---

## 📊 Key Metrics & Insights Generated

These scripts help answer questions like:
- ✅ What is the success rate of each space agency?
- ✅ How have space missions evolved over the decades?
- ✅ Which launch sites are most active?
- ✅ What are the most reliable rockets?
- ✅ How do countries compare in space exploration?
- ✅ What types of missions are most common?
- ✅ What orbital destinations are most targeted?
- ✅ Are there seasonal patterns in launches?

---

## 🔗 Integration with Power BI

The views created by these scripts are specifically designed to:
- Provide clean data sources for Power BI dashboards
- Optimize query performance for visualizations
- Enable dynamic filtering and drill-down capabilities
- Support real-time dashboard updates

To connect Power BI:
1. Run all SQL scripts to prepare data and views
2. Open Power BI Desktop
3. Get Data → SQL Server (or your database)
4. Connect to your database
5. Import the views created by `SPACE ANALYSIS VIEWS.sql`
6. Build visualizations using the cleaned data

---

## 📝 Customization

Feel free to modify these scripts to:
- Add custom metrics specific to your analysis
- Create additional views for specialized queries
- Adjust date ranges or filters
- Add new aggregation dimensions
- Incorporate additional data sources

---

## 🐛 Troubleshooting

**Issue**: Syntax errors when running scripts
- **Solution**: Check database compatibility (SQL Server vs MySQL syntax)

**Issue**: Missing tables or columns
- **Solution**: Ensure CSV data is imported before running scripts

**Issue**: Slow query performance
- **Solution**: Add indexes on frequently queried columns (Date, Agency, Country)

**Issue**: Views not showing data
- **Solution**: Verify base tables have data and refresh views

---

## 🔗 Related Files

- See `/data` folder for source CSV files
- See `/dashboards` folder for Power BI visualizations using these views
- See main README.md for complete project documentation

---

**Note**: These scripts are designed for educational and analytical purposes. Modify SQL syntax as needed for your specific database system.
