-- 📊 Overview of Clean Data
SELECT * FROM layoffs_staging2;

-- 📌 1. Max Layoffs and Max Percentage
SELECT 
    MAX(total_laid_off) AS max_total_laid_off, 
    MAX(percentage_laid_off) AS max_percentage_laid_off
FROM layoffs_staging2;

-- 🔍 2. Companies with 100% Layoffs and Highest Funding
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- 🏢 3. Total Layoffs Per Company Per Year
SELECT 
    company, 
    YEAR(`date`) AS year, 
    SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY company, year
ORDER BY total_laid_off DESC, company ASC;

-- 📅 4. Date Range of the Dataset
SELECT 
    MIN(`date`) AS start_date, 
    MAX(`date`) AS end_date
FROM layoffs_staging2;

-- 🏭 5. Total Layoffs by Industry
SELECT 
    industry, 
    SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY industry
ORDER BY total_laid_off DESC;

-- 🌍 6. Total Layoffs by Country
SELECT 
    country, 
    SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY country
ORDER BY total_laid_off DESC;

-- 🚀 7. Total Layoffs by Startup Stage
SELECT 
    stage, 
    SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY stage
ORDER BY total_laid_off DESC;

-- 📆 8. Monthly Layoffs Trend
SELECT 
    DATE_FORMAT(`date`, '%Y-%m') AS month, 
    SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE `date` IS NOT NULL
GROUP BY month
ORDER BY month ASC;

-- 📈 9. Rolling Cumulative Layoffs by Month
WITH monthly_totals AS (
    SELECT 
        DATE_FORMAT(`date`, '%Y-%m') AS month, 
        SUM(total_laid_off) AS total_laid_off
    FROM layoffs_staging2
    WHERE `date` IS NOT NULL
    GROUP BY month
)
SELECT 
    month, 
    total_laid_off,
    SUM(total_laid_off) OVER (ORDER BY month) AS rolling_total
FROM monthly_totals;

-- 🏆 10. Top 5 Companies with Highest Layoffs Each Year
WITH company_yearly AS (
    SELECT 
        company, 
        YEAR(`date`) AS year, 
        SUM(total_laid_off) AS total_laid_off
    FROM layoffs_staging2
    GROUP BY company, year
),
ranked_companies AS (
    SELECT *, 
           DENSE_RANK() OVER (PARTITION BY year ORDER BY total_laid_off DESC) AS rank_tlf
    FROM company_yearly
    WHERE year IS NOT NULL
)
SELECT *
FROM ranked_companies
WHERE rank_tlf <= 5;
