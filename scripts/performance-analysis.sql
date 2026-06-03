-- Analyze the yearly performance of products by comparing their sales 
-- to both the average sales performance and the previous years sales
WITH
  yearly_product_sales
  as
  (
    SELECT
      YEAR(f.order_Date) as order_year,
      p.product_name as product_name,
      SUM(f.sales_amount) as current_sales
    FROM gold.fact_sales f
      LEFT JOIN gold.dim_products p
      ON f.product_key = p.product_key
    WHERE f.order_Date IS NOT NULL
    GROUP BY  YEAR(f.order_Date),   p.product_name
  )
SELECT
  order_year,
  product_name,
  AVG(current_sales) OVER(PARTITION BY product_name) as avg_price,
  current_sales - AVG(current_sales) OVER(PARTITION BY product_name) AS diff_avg,
  CASE 
      WHEN  current_sales - AVG(current_sales) OVER(PARTITION BY product_name) > 0 THEN 'Above AVG'
      WHEN  current_sales - AVG(current_sales) OVER(PARTITION BY product_name) < 0 THEN 'Belowe AVG'
      ELSE 'Avg'
    END AS avg_change,
    -- Year-over-year analysis
  LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) as previous_years_sales,
  current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) AS diff_years,
  CASE 
      WHEN  current_sales -  LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
      WHEN  current_sales -  LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
      ELSE 'No change'
    END AS py_change
FROM yearly_product_sales
ORDER BY product_name, order_year


