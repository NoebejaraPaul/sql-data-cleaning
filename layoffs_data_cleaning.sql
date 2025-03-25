-- Data cleaning

-- Remove duplicates 
-- Standardize data (Fixing errors like spelling )
-- null/blank blak vales
-- remove rows/ unwanted rows 

-- REMOVE DUPLICATES

SELECT *
FROM layoffs;

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT INTO layoffs_staging
SELECT *
FROM layoffs;
WITH duplicated_data AS(
	SELECT *, 
	ROW_NUMBER() 
	OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, funds_raised_millions) AS row_num
	FROM layoffs_staging
)
SELECT * -- (can be deleted straight from CTE )
FROM duplicated_data
WHERE row_num > 1;

-- Create another table to delete duplicate on
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_staging2
	SELECT *, 
	ROW_NUMBER() 
	OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, funds_raised_millions) AS row_num
	FROM layoffs_staging
;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;

SELECT *
FROM layoffs_staging2;

-- Standardlizing data (Spelling and spaces checking)

SELECT DISTINCT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT industry
FROM layoffs_staging2
WHERE industry LIKE "Crypto%"
ORDER BY 1;

UPDATE layoffs_staging2
SET industry = "Crypto"
WHERE industry LIKE "Crypto%";

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

SELECT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
WHERE country LIKE "United States";

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE "United States%";

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

-- WORKIG WIT DATES

SELECT 	`date`, STR_TO_DATE(`date`, '%m/%d/%Y') as text_to_date
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT *
FROM layoffs_staging2;

-- CHANGE date colunm to DATE datatype
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- REMOVE NULLS AND BLANK VALAUES
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

SELECT * 
FROM layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

-- POPULATE industry with the matching ones
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- DELETE THIS DATA AS IS HAS BOTH NULLS OD DATA THAT I AM GOING TO USE
DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- DELETE row_num column as we know longer need it
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT *
FROM layoffs_staging2;










