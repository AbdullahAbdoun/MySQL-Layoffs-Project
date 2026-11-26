# Global Layoffs Analysis: Data Cleaning & Exploratory Data Analysis (SQL)

An end-to-end **MySQL** data analytics project covering **Data Cleaning** and **Exploratory Data Analysis (EDA)** on a global layoffs dataset (`2020–2023`). The goal of this project is to transform raw, inconsistent data into clean, reliable tables and extract actionable business insights across industries, geographies, funding stages, and time.

---

## 📁 Repository Structure

```text
├── README.md                  # Project overview, methodology, data quality notes & key findings
├── layoffs_data_cleaning.sql  # Data cleaning & standardization pipeline
└── layoffs_EDA.sql            # 20+ exploratory data analysis queries
```

---

## 🧹 Phase 1: Data Cleaning (`layoffs_data_cleaning.sql`)

Before running any analysis, a staging workflow was used so the raw data remained untouched while preparing clean tables (`layoffs_staging` and `layoffs_staging2`):

* **Duplicate Removal:** Identified and removed exact duplicate records using `ROW_NUMBER()` partitioned across key attributes (`company`, `location`, `industry`, `total_laid_off`, `percentage_laid_off`, `date`, `stage`, `country`, `funds_raised_millions`).
* **Text Standardization:** Trimmed leading/trailing whitespace (`TRIM()`) and standardized inconsistent naming—such as unifying crypto-related labels (`Crypto`, `Crypto Currency`, `CryptoCurrency` → `Crypto`) and cleaning trailing punctuation in country names (e.g., `United States.` → `United States`).
* **Date & Data Type Formatting:** Converted string dates into proper `DATE` format using `STR_TO_DATE()` and altered column data types accordingly.
* **Null & Blank Handling:** Populated missing `industry` values from matching company records where possible using self-joins, and removed rows lacking usable layoff metrics (`total_laid_off` and `percentage_laid_off` both null) along with helper columns like `row_num`.

---

## 📊 Phase 2: Exploratory Data Analysis (`layoffs_EDA.sql`)

Following data cleaning, 20+ structured SQL queries were written across four analytical sections:

1. **Initial Overview & Extremes:** Peak single-event layoffs, 100% workforce shut-downs ordered by funding raised, and dataset date coverage.
2. **Aggregations:** Breakdowns by `company`, `industry`, `country` (including a dedicated look at Egypt), `year`, funding `stage`, and cumulative layoff percentages.
3. **Time Series, Rolling Totals & Yearly Rankings:** Calendar-month vs. chronological (`YYYY-MM`) trends, cumulative and yearly-reset rolling totals via window functions, and **Top 5 Companies per Year** using CTEs and `DENSE_RANK()`.
4. **Advanced Business & Correlation Questions:** High-funding companies with layoffs, industry average layoff percentages (filtered to industries with at least 5 events), repeat-offender companies across multiple layoff rounds, each industry's share (`%`) of global layoffs, top 10 affected cities with distinct company counts, and **Top 3 Industries per Year**.

---

## 🔍 Key Insights & Findings

* **Shifting Industry Impact Over Time:** **Consumer** and **Retail** saw heavy cumulative layoffs overall, while annual leaders shifted with macroeconomic conditions—**Transportation** and **Travel** topped 2020 during pandemic disruptions, before **Retail**, **Consumer**, and broader categories surged in 2022–2023.
* **Geographic Concentration:** **SF Bay Area** recorded the highest layoff volume (**125,601** employees across **419** distinct companies), ahead of **Seattle** (**34,743**) and **New York City** (**29,364**).
* **Repeat Layoff Waves:** Several companies executed multiple layoff rounds over the period (such as **Loft** with 6 rounds, **Uber** with 5 rounds / **7,585** laid off, and **Salesforce** with 4 rounds / **10,090** laid off).
* **Funding Doesn't Guarantee Immunity:** Strong prior funding or later stages did not prevent layoffs across multiple high-capital companies.

---

## ⚠️ Data Quality Note

* While aggregating by city and country (`GROUP BY location, country`), minor raw-data labeling inconsistencies were observed where a small number of non-U.S. cities (such as *Stockholm* in *Sweden* and *São Paulo* in *Brazil*) had records mislabeled as *United States*. Grouping by both `location` and `country` separated the accurate country mappings cleanly without altering raw source records.

---

## 🛠️ SQL Techniques Used

* **CTEs & Subqueries** (multi-step rankings and global percentage calculations)
* **Window Functions:** `ROW_NUMBER()`, `DENSE_RANK()`, `SUM() OVER()` (overall & yearly-reset rolling totals)
* **Aggregations & Filtering:** `GROUP BY`, `HAVING`, `COUNT(DISTINCT)`, `ROUND()`
* **String & Date Functions:** `TRIM()`, `STR_TO_DATE()`, `YEAR()`, `SUBSTRING()`
