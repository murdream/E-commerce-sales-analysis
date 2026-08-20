-- 1. Общая выручка

SELECT SUM(revenue) AS total_revenue FROM sales;

-- 2. Количество заказов

SELECT COUNT(order_id) AS total_order FROM sales;

-- 3. Средний чек

SELECT ROUND(SUM(revenue) / COUNT(DISTINCT order_id), 2) AS  avg_check FROM sales;

-- 4. Выручка по категориям

SELECT product_category, SUM(revenue) as category_revenue FROM sales 
GROUP BY product_category 
ORDER BY category_revenue  DESC;

-- 5. Выручка по регионам

SELECT region, SUM(revenue) as region_revenue FROM sales 
GROUP BY region
ORDER BY region_revenue  DESC;

-- 6. Выручка по месяцам

SELECT month_name, SUM(revenue) AS month_revenue FROM sales
GROUP BY month_name
ORDER BY month;

-- 7. Количество заказов по дням недели

SELECT day_name, COUNT(order_id) AS orders_by_day FROM sales 
GROUP BY day_name
ORDER BY day_of_week;

-- 8. Топ-3 заказа в каждой категории

WITH ranked AS (
SELECT order_id, product_category, revenue, ROW_NUMBER() OVER(PARTITION BY product_category ORDER BY revenue DESC) AS rn
FROM sales
)
SELECT product_category, order_id, revenue, rn FROM ranked 
WHERE rn <= 3
ORDER BY product_category, rn;

-- 9. Сравнение выручки с предыдущим месяцем

SELECT month_name, ROUND(SUM(revenue), 2) as current_month_revenue,
LAG(ROUND(SUM(revenue), 2), 1) OVER (ORDER BY month) as previous_month_revenue
FROM sales 
GROUP BY month_name
ORDER BY month;
