# 📉 Layoffs Data Cleaning

## � Introduction
This project focuses on cleaning a dataset of global layoffs from major companies (2020-2023). Using SQL, we ensure the data is clean, standardized, and ready for analysis.

🔍 **Check out the SQL queries used in this project:** [SQL Cleaning Scripts](#) *()*

## 🔎 Background
Handling real-world data often involves dealing with duplicates, inconsistencies, and missing values. This project applies a structured SQL-based cleaning process to prepare the layoffs dataset for meaningful analysis.

## 🛠 Data Cleaning Process

### 🔹 Removing Duplicates
- Used `ROW_NUMBER()` with `PARTITION BY` to identify duplicate records
- Created a staging table (`layoffs_staging2`) to store deduplicated data
- Ensured only unique entries were retained

### 🔹 Standardizing Data
- Fixed spelling inconsistencies in company names, locations, and industries
- Standardized text formats

### 🔹 Handling Missing Values
- Replaced missing values where necessary
- Removed rows with crucial missing data

### 🔹 Filtering Unwanted Rows
- Removed incomplete and erroneous records

## ⚙️ Tools Used
- 🛢 MySQL Workbench for SQL queries and data cleaning
- 📂 Kaggle for dataset sourcing

## 📚 What I Learned
- The importance of data cleaning in ensuring accuracy and reliability for analysis
- How to use SQL functions like `ROW_NUMBER()` to detect duplicates efficiently
- Best practices for handling missing data and maintaining data integrity
- The significance of standardizing values to avoid inconsistencies

## 🔍 Conclusion
Data cleaning is a crucial step in any data analysis project. By applying structured SQL techniques, we transformed raw, messy data into a reliable dataset suitable for insights and decision-making.

## 💡 Closing Thoughts
This project reinforced the importance of systematic data cleaning, preparing me for future data-driven projects. Next steps include automating the cleaning process and integrating it with visualization tools for deeper analysis.
