WITH sales AS (
    SELECT * FROM {{ ref('stg_raw__sales') }}
),
ship AS (
    SELECT * FROM {{ ref('stg_raw__ship') }}
),
product AS (
    SELECT * FROM {{ ref('stg_raw__product') }}
),
joined AS (
    SELECT
        s.date_date,
        s.orders_id,
        s.revenue,
        s.quantity,
        s.pdt_id,
        p.purchase_price,
        sh.shipping_fee,
        sh.log_cost,
        sh.ship_cost
    FROM sales s
    LEFT JOIN product p ON s.pdt_id = p.products_id
    LEFT JOIN ship sh ON s.orders_id = sh.orders_id
)

SELECT
    date_date AS date,
    COUNT(DISTINCT orders_id) AS total_transactions,
    SUM(revenue) AS total_revenue,
    ROUND(SUM(revenue) / COUNT(DISTINCT orders_id), 2) AS average_basket,
    SUM(shipping_fee + log_cost + ship_cost) AS operational_margin,
    SUM(purchase_price * quantity) AS total_purchase_cost,
    SUM(shipping_fee) AS total_shipping_fees,
    SUM(log_cost + ship_cost) AS total_log_costs,
    SUM(quantity) AS total_quantity_sold
FROM joined
GROUP BY date_date
ORDER BY date