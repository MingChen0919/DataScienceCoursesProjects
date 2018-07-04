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

/* step 0: the final table should have these columns: sku, year, total summer sale price.
   step 1: mark a transaction if it occurred in summer or not (CASE).
   step 2: filter only summer transactions (WHERE).
   step 3: aggregate sale price by sku, year (GROUP BY)
   step 4: sort by aggregated sale price (ORDER BY)
 */
SELECT
    sku,
    EXTRACT(YEAR FROM saledate) AS year_num,
    SUM(sprice) AS total_sprice,
    CASE
      WHEN EXTRACT(MONTH FROM saledate) IN (6,7,8) THEN 'summer'
      ELSE 'not summer'
      END AS summer_months
FROM trnsact
WHERE summer_months='summer'
GROUP BY sku, year_num, summer_months
ORDER BY total_sprice DESC;

