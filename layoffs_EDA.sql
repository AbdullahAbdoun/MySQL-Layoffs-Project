--  ====== EDA Explortory Data Analysis ========

select max(total_laid_off) ,max(percentage_laid_off) from layoffs_staging2;
select * from layoffs_staging2
where percentage_laid_off = 1
ORDER BY funds_raised_millions desc;

select company , sum(total_laid_off)
from layoffs_staging2 
GROUP BY company
ORDER BY 2 desc
;
select min(`date`) ,max(`date`)
FROM layoffs_staging2;
select industry , sum(total_laid_off)
from layoffs_staging2 
GROUP BY industry
ORDER BY 2 desc;
SELECT * from layoffs_staging2;
select country , sum(total_laid_off)
from layoffs_staging2 
GROUP BY country
ORDER BY 2 desc;
SELECT * from layoffs_staging2
where country = 'Egypt';

select year(`date`) ,sum(total_laid_off) FROM layoffs_staging2
GROUP BY year(`date`)
order by 2 desc;


select stage , sum(total_laid_off)
from layoffs_staging2 
GROUP BY stage
ORDER BY 2 desc;
select company , sum(percentage_laid_off)
from layoffs_staging2 
GROUP BY company
ORDER BY 2 desc;

-- Time series
SELECT `date` from layoffs_staging2;
SELECT 
    SUBSTRING(`date`, 6, 2) AS `month`, SUM(total_laid_off)
FROM
    layoffs_staging2
GROUP BY `month`;

SELECT 
    SUBSTRING(`date`, 1, 7) AS `month`, SUM(total_laid_off)
FROM
    layoffs_staging2
WHERE
    `date` IS NOT NULL
GROUP BY 1
ORDER BY 1;
-- Rolling total
with rolling_total as
(	SELECT 
    SUBSTRING(`date`, 1, 7) AS `month`, SUM(total_laid_off) as total_off
FROM
    layoffs_staging2
WHERE
    `date` IS NOT NULL
GROUP BY 1
ORDER BY 1
)

SELECT `month` , total_off,
sum(total_off) over(ORDER BY `month`) as rollingTotal

from rolling_total;

with Yearly_rolling_total as
(	SELECT 
    SUBSTRING(`date`, 1, 7) AS `month`, SUM(total_laid_off) as total_off
FROM
    layoffs_staging2
WHERE
    `date` IS NOT NULL
GROUP BY 1
ORDER BY 1
)
## Yearly_ROlling_Total
SELECT `month` , total_off,
sum(total_off) over(PARTITION BY substring(`month`,1,4)
ORDER BY `month`) as yearlyRollingTotal
from Yearly_rolling_total;

SELECT 
    company, YEAR(`date`), SUM(total_laid_off) 
FROM
    layoffs_staging2
    WHERE `date` is not null
   GROUP BY company ,YEAR(`date`)
   ORDER BY YEAR(`date`)
   
   ;
   
   with company_Year as
   (	
		SELECT 
    company, YEAR(`date`) as years, SUM(total_laid_off) total_laid_off
FROM
    layoffs_staging2
    WHERE `date` is not null
   GROUP BY company ,YEAR(`date`)
   
   ) , Ranking_companies as (
    
    
   SELECT *,
   DENSE_RANK() over(PARTITION BY years order by total_laid_off desc) Ranking
   from company_Year

	)
    select * from Ranking_companies
    where Ranking <=5;
  



