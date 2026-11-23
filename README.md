# Global Layoffs Data Cleaning Project (MySQL)

## Project Overview
This project focuses on cleaning and preparing a real-world global layoffs dataset using **MySQL**. The goal is to transform raw, inconsistent data into a clean, reliable, and analysis-ready dataset suitable for Exploratory Data Analysis (EDA) and visualization.

## Key Cleaning Steps
1. **Staging Tables**: Created staging tables (`layoffs_staging` and `layoffs_staging2`) to preserve the raw data and safely perform transformations without risking original records.
2. **Removing Duplicates**: Identified duplicate records using `ROW_NUMBER()` over key columns with `PARTITION BY` and removed duplicate rows cleanly.
3. **Standardizing Data**:
   - Trimmed leading/trailing whitespace (`TRIM`) across text fields such as `company`.
   - Standardized inconsistent category and location naming (e.g., unifying variations like `"Crypto"` and `"United States"`).
4. **Date Formatting**: Converted the `date` column from string format to a proper `DATE` data type (`YYYY-MM-DD`) using `STR_TO_DATE` and `ALTER TABLE`.
5. **Handling Null & Blank Values**:
   - Converted empty strings (`''`) to `NULL` where appropriate.
   - Populated missing `industry` values using a self-join on matching company records when available.
   - Removed rows lacking essential layoff metrics (`total_laid_off` and `percentage_laid_off` both `NULL`) where no analytical value is provided.
6. **Dropping Unnecessary Columns**: Removed helper columns (such as `row_num`) once cleaning was completed.

## Tools & Technologies
- **Database**: MySQL / MySQL Workbench
- **SQL Concepts**: CTEs, Window Functions (`ROW_NUMBER()`), Self-Joins, Data Type Conversion, `UPDATE` / `DELETE` / `ALTER TABLE`

## Repository Contents
- `layoffs_data_cleaning.sql` — Full SQL script containing all data cleaning steps and verification queries.
- `README.md` — Project documentation and workflow summary.

## Next Steps
- Perform **Exploratory Data Analysis (EDA)** in MySQL to uncover trends across industries, countries, companies, and time periods.
- Build interactive dashboards and visualizations to communicate key insights.