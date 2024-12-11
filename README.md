# OCD Patients Health Analytics Project

## Overview
This project aims to analyze and visualize data related to OCD patients, leveraging Python for data cleaning, SQL for querying, and Power BI for interactive dashboards. The focus is on uncovering trends, correlations, and actionable insights to support healthcare professionals in improving patient outcomes.

## Objectives
1. Implement an analytics framework to process and analyze OCD patient data efficiently.
2. Extract key insights into patient demographics, symptom patterns, and comorbid conditions.
3. Develop visualizations to assist in decision-making and enhance the understanding of OCD treatment outcomes.

## Key Features
- **Data Cleaning:**
  - Used Python libraries (Pandas, NumPy) to preprocess the dataset.
  - Addressed missing data, standardized formats, and resolved inconsistencies to ensure clean and usable data.

- **SQL Insights:**
  - Utilized SQL queries to extract insights from attributes like Y-BOCS scores, obsession and compulsion types, and comorbid conditions.
  - Investigated correlations between demographic factors and treatment outcomes.

- **Data Visualization:**
  - Designed interactive dashboards using Power BI.
  - Key metrics visualized include symptom duration, Y-BOCS scores, and medication patterns.

## Tools and Technologies
- **Programming Languages:** Python (Pandas, NumPy, Matplotlib, Seaborn)
- **Databases:** SQL (PostgreSQL)
- **Visualization Tools:** Power BI

## Impact
- Enhanced understanding of OCD symptom patterns and their correlations with demographic factors.
- Provided actionable insights for healthcare practitioners to improve treatment strategies.
- Highlighted key performance indicators like symptom duration and therapy effectiveness.

## Installation and Usage
1. Clone this repository:
   ```bash
   git clone https://github.com/your-repository-link
   ```
2. Install required Python libraries:
   ```bash
   pip install pandas numpy matplotlib seaborn
   ```
3. Run the data cleaning scripts:
   ```bash
   python data_cleaning.py
   ```
4. Execute SQL queries from the `sql_queries` folder to derive insights:
   ```sql
   -- Example Query
   SELECT * FROM patients_data WHERE duration_of_symptoms > 12;
   ```
5. Open Power BI dashboards (`.pbix` files) to explore visualized insights.

## Project Files
- **data_cleaning.py:** Python script for cleaning and preprocessing patient data.
- **sql_queries:** Folder containing SQL scripts for querying insights.
- **dashboards:** Power BI files for visualizations.

## Future Enhancements
- Integration of machine learning models for predicting patient outcomes.
- Expansion to include real-time analytics for dynamic insights.
- Addition of more datasets to explore broader mental health conditions.

## Acknowledgments
Special thanks to contributors and healthcare professionals who provided valuable insights for this project.

## Contact
For queries or collaborations, feel free to reach out at birewarrushi0@gmail.com .

