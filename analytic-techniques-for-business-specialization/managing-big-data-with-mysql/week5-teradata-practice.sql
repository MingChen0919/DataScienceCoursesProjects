/*  1. How many distinct dates are there in the saledate column of the transaction table for
each month/year combination in the database. */

SELECT
  EXTRACT(YEAR FROM saledate) AS year_number,
  EXTRACT(MONTH FROM saledate) AS month_number,
  COUNT(DISTINCT(EXTRACT(DAY FROM saledate))) AS day_count
FROM trnsact
GROUP BY year_number, month_number;

/* 2. Use a CASE statement within an aggregate function to determine which sku
had the greatest total sales during the combined summer months of June, July, and August. */

/* get year, month, sale price and a fourth column to indicate if this is a summer month,
and filter output by summer_months*/
SELECT
    sku,
    EXTRACT(YEAR FROM saledate) AS year_num,
    EXTRACT(MONTH FROM saledate) AS month_num,
    sprice,
    CASE
      WHEN EXTRACT(MONTH FROM saledate) IN (6,7,8) THEN 'summer'
      ELSE 'not summer'
      END AS summer_months
FROM trnsact
WHERE summer_months='summer';

/* group by sku, year, month from previous output and aggregate sprice*/
SELECT
  summer_sales.sku,
  summer_sales.year_num,
  summer_sales.month_num,
  SUM(summer_sales.sprice) AS total_sprice
FROM
  (SELECT
    sku,
    EXTRACT(YEAR FROM saledate) AS year_num,
    EXTRACT(MONTH FROM saledate) AS month_num,
    sprice,
    CASE
      WHEN EXTRACT(MONTH FROM saledate) IN (6,7,8) THEN 'summer'
      ELSE 'not summer'
      END AS summer_months
  FROM trnsact
  WHERE summer_months='summer') AS summer_sales
GROUP BY 1, 2, 3
ORDER BY total_sprice;