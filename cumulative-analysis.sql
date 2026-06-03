-- Calculate the total sales per month
-- and the running total of sales over time

SELECT
  order_date,
  total_sales,
  SUM(total_sales) 
  OVER(ORDER BY order_date) AS running_total_sales,
  AVG(avg_price) OVER(ORDER BY order_date) as moving_avg
FROM (
SELECT
    DATETRUNC(month, order_Date) as order_date,
    SUM(sales_amount) as total_sales,
    AVG(price) as avg_price
  FROM gold.fact_sales
  WHERE order_Date IS NOT NULL
  GROUP BY DATETRUNC(month, order_Date)
) t


-- Calculate the total sales per year   
-- and the running total of sales over time
SELECT
  order_date,
  total_sales,
  SUM(total_sales) OVER(ORDER BY order_date) as running_total_sales,
  AVG(avg_price) OVER(ORDER BY order_date) as avg_running_price
FROM (
SELECT
    DATETRUNC(YEAR, order_Date) as order_date,
    SUM(sales_amount) as total_sales,
    AVG(price) as avg_price
  FROM gold.fact_sales
  WHERE order_Date IS NOT NULL
  GROUP BY DATETRUNC(YEAR, order_Date)
) t