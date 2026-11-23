use world_layoffs;
 select * from layoffs;
 
 create table layoffs_staging
 like layoffs;
  select * from layoffs_staging;
  
  insert layoffs_staging
  select * from layoffs;

with duplicate_cte as
  (
  select *,
  row_number() over(
  partition by
  company , location , industry , total_laid_off , percentage_laid_off
  , `date` , stage , country , funds_raised_millions) row_num1
  from layoffs_staging
  )
  SELECT * from duplicate_cte;

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
  `row_num1` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
SELECT * from layoffs_staging2;

INSERT into layoffs_staging2
  select *,
  row_number() over(
  partition by
  company , location , industry , total_laid_off , percentage_laid_off
  , `date` , stage , country , funds_raised_millions) row_num1
  from layoffs_staging;
  
  delete from layoffs_staging2 
  where row_num1 > 1;
  
  -- Standardizing data 
SELECT DISTINCT
    company, TRIM(company)
FROM
    layoffs_staging2;
       UPDATE layoffs_staging2 
SET 
    company = TRIM(company);
    
      SELECT DISTINCT industry from layoffs_staging2
  ORDER BY 1 ;#industry
  
  SELECT * from layoffs_staging2 WHERE
industry LIKE 'Crypto%';
 SELECT * from layoffs_staging2;
 
    SELECT DISTINCT country from layoffs_staging2
  ORDER BY 1 ;

UPDATE layoffs_staging2 
SET 
    industry = 'Crypto'
WHERE
    industry LIKE 'Crypto%';

  SELECT DISTINCT country, trim(trailing '.' from country) from layoffs_staging2
    order by 1;
 update layoffs_staging2 
    set country = trim(trailing '.' from country)
    WHERE country like 'United States%';
    
    SELECT `date`,
str_to_date(`date`,'%m/%d/%Y') FROM layoffs_staging2;
update layoffs_staging2 
    set `date` = str_to_date(`date`,'%m/%d/%Y') ;
    SELECT * from layoffs_staging2;
    alter table layoffs_staging2 
    modify column `date` date;
    SELECT DISTINCT `date` from layoffs_staging2
    ORDER BY 1;
    
   select * from layoffs_staging_2
where total_laid_off is null
and percentage_laid_off is null;

select * from layoffs_staging2
where industry is null
or industry = '';

SELECT 
    t1.company, t1.industry, t2.company, t2.industry
FROM
    layoffs_staging2 t1
        JOIN
    layoffs_staging2 t2 ON t1.company = t2.company
HAVING
    (t1.industry IS NULL OR t1.industry = '')
        AND t2.industry IS NOT NULL;
        
   update layoffs_staging2 
   set industry = NULL 
   where industry = '' ; 
        
        UPDATE layoffs_staging2 t1
        JOIN
    layoffs_staging2 t2 ON t1.company = t2.company 
SET 
    t1.industry = t2.industry
WHERE
    t1.industry IS NULL 
        AND t2.industry IS NOT NULL;
        select * from layoffs_staging2
        where company = 'Airbnb';
    select count(* ), industry from layoffs_staging2
    GROUP BY industry; 
    SELECT * from layoffs_staging2 
    where company like 'Bally''s Inte%';
    
     select * from layoffs_staging2
     
where total_laid_off is null
and percentage_laid_off is null;
DELETE FROM layoffs_staging2 
WHERE
    total_laid_off IS NULL
    AND percentage_laid_off IS NULL;
    ALTER table
     layoffs_staging2
     drop column `row_num1`;
 SELECT * from layoffs_staging2;
 
 
 
 
 