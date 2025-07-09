
# 🧠 Layoff Trends Analysis Using SQL

This project showcases how to clean and analyze real-world layoff data using SQL. 
It provides structured steps for data cleaning and exploratory data analysis (EDA), 
highlighting layoff patterns across industries, countries, and companies over time.

---

## 📁 Dataset

The dataset was sourced from [Kaggle](https://www.kaggle.com/datasets/swaptr/layoffs-2022) and contains detailed information on company layoffs, including the following fields:

- `company`, `location`, `industry`, `total_laid_off`, `percentage_laid_off`, `date`, `stage`, `country`, and `funds_raised_millions`.

---

## 🔧 Data Cleaning (SQL)

Data cleaning is performed using MySQL and includes:

1. **Duplicate Removal** – using ROW_NUMBER() with CTEs.
2. **Standardization** – trimming strings, unifying names.
3. **Date Formatting** – converting string to DATE format.
4. **Handling Missing Values** – filling in industry using self-join.
5. **Dropping Irrelevant Columns** – cleaning up the final schema.

The clean data is stored in a staging table `layoffs_staging2`.

---

## 📊 Exploratory Data Analysis (EDA)

Various SQL queries were used to extract insights from the data, including:

- Maximum layoffs and full-percentage layoffs
- Total layoffs by company, year, industry, and country
- Rolling cumulative layoffs over time
- Top 5 companies by layoffs for each year

These queries use SQL features such as `GROUP BY`, `ORDER BY`, `DATE_FORMAT`, `CTEs`, and window functions like `DENSE_RANK()`.

---

## 📌 Tools Used

- SQL (MySQL)
- Window Functions
- CTEs
- Data Standardization Techniques

---

## 📈 Possible Extensions

- Power BI / Tableau dashboards
- Python visualizations (Matplotlib, Seaborn)
- Predictive analytics on layoff trends
- Correlation between funding and layoffs

---

## 🗂️ Repository Structure

- `Data Cleaning.sql`: Full data preparation steps
- `EDA.sql`: All queries used for analysis
- `layoffs.csv`: Source dataset

---

### 📧 Contact

For any queries or collaboration opportunities, feel free to connect:

**Ayush Paderiya**
📫 \[[paderiyaayush@gmail.com](mailto:paderiyaayush@gmail.com)]
🌐 [LinkedIn](www.linkedin.com/in/ayush-paderiya-94b2a3131) 

