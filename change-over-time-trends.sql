-- Analyze Sales performance Over Time
-- BY YEARS
SELECT
  YEAR(order_Date) AS order_year,
  SUM(sales_amount) AS total_sales,
  COUNT(DISTINCT customer_key) as total_customers,
  SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_Date IS NOT NULL
GROUP BY  YEAR(order_Date)
ORDER BY YEAR(order_Date)

-- Analyze Sales performance Over Time By Months
SELECT
  DATETRUNC(month, order_Date) AS order_month,
  -- FORMAT(order_Date, 'yyyy-MMM') as order_month,
  SUM(sales_amount) AS total_sales,
  COUNT(DISTINCT customer_key) as total_customers,
  SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_Date IS NOT NULL
GROUP BY  DATETRUNC(month, order_Date)
ORDER BY  DATETRUNC(month, order_Date)
-- GROUP BY FORMAT(order_Date, 'yyyy-MMM')
-- ORDER BY  FORMAT(order_Date, 'yyyy-MMM')

