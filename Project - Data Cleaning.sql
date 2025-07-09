-- 📦 STEP 1: Create Staging Table from Original
CREATE TABLE layoffs_staging LIKE layoffs;

INSERT INTO layoffs_staging
SELECT * FROM layoffs;

-- 📌 STEP 2: Identify Duplicates Using ROW_NUMBER
WITH duplicate_cte AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY company, location, industry, total_laid_off, 
                         percentage_laid_off, `date`, stage, country, funds_raised_millions
        ) AS row_num
    FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- 🧹 STEP 3: Remove Duplicates & Create Clean Table
CREATE TABLE layoffs_staging2 (
    company TEXT, 
    location TEXT, 
    industry TEXT, 
    total_laid_off INT DEFAULT NULL, 
    percentage_laid_off TEXT, 
    `date` TEXT, 
    stage TEXT, 
    country TEXT, 
    funds_raised_millions INT DEFAULT NULL,
    row_num INT
);

INSERT INTO layoffs_staging2
SELECT *, 
    ROW_NUMBER() OVER (
        PARTITION BY company, location, industry, total_laid_off, 
                     percentage_laid_off, `date`, stage, country, funds_raised_millions
    ) AS row_num
FROM layoffs_staging;

DELETE FROM layoffs_staging2
WHERE row_num > 1;

-- 🧽 STEP 4: Standardize Company Names
UPDATE layoffs_staging2
SET company = TRIM(company);

-- 🧽 STEP 5: Standardize Industry Names (e.g., "Crypto", etc.)
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- 🧽 STEP 6: Standardize Country Names
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- 🗓️ STEP 7: Convert `date` Column to Proper DATE Format
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- 🩹 STEP 8: Fix Missing Industries via Self-Join
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2 USING (company)
SET t1.industry = t2.industry
WHERE t1.industry IS NULL AND t2.industry IS NOT NULL;

-- 🗑️ STEP 9: Remove Completely Null Layoff Records
DELETE FROM layoffs_staging2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

-- 🧹 STEP 10: Drop Helper Columns
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;
