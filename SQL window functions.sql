-- SQL window functions are powerful for performing calculations across a set of table rows related to the current row. Let's go through some common SQL window functions with examples:

-- 1. ROW_NUMBER()
-- The ROW_NUMBER() function assigns a unique sequential integer to rows within a partition of a result set, starting at 1 for the first row in each partition

	SELECT 
    company, 
    total_laid_off, 
    ROW_NUMBER() OVER (ORDER BY total_laid_off DESC) AS row_num
FROM 
    layoffs_test2;
-- 2. RANK()
-- The RANK() function assigns a rank to each row within a partition of a result set. Ranks may have gaps: the next rank after a tie is the rank plus the number of tied rows.

SELECT 
    company, 
    total_laid_off, 
    RANK() OVER (ORDER BY total_laid_off DESC) AS rankd
FROM 
    layoffs_test2;
-- 3. DENSE_RANK()
-- The DENSE_RANK() function assigns ranks to rows within a partition of a result set, similar to RANK(), but without gaps between rank values.
SELECT 
    company, 
    total_laid_off, 
    DENSE_RANK() OVER (ORDER BY total_laid_off DESC) AS dense_ryank
FROM 
    layoffs_test2;
-- Calculate Row Number for Each Industry
-- Assign a row number to each company within each industry based on total layoffs in descending order.
SELECT 
    company, 
    industry, 
    total_laid_off, 
    ROW_NUMBER() OVER (PARTITION BY industry ORDER BY total_laid_off DESC) AS row_num
FROM 
    layoffs_test2;
SELECT 
    company, 
    industry, 
    total_laid_off, 
    SUM(total_laid_off) OVER (PARTITION BY industry ORDER BY total_laid_off DESC) AS cumulative_sum
FROM 
    layoffs_test2;

SELECT 
    company, YEAR(date), SUM(total_laid_off)
FROM
    layoffs_test2
  
GROUP BY company , YEAR(date)
  order by SUM(total_laid_off) desc ;
  -- Calculate Cumulative Sum of Layoffs by Year
  SELECT 
    company, 
    YEAR(date) AS year, 
    SUM(total_laid_off) AS total_laid_off,
    SUM(SUM(total_laid_off)) OVER (PARTITION BY YEAR(date) ORDER BY SUM(total_laid_off) DESC) AS cumulative_sum
FROM
    layoffs_test2
GROUP BY 
    company, 
    YEAR(date)
ORDER BY 
    year, cumulative_sum;
