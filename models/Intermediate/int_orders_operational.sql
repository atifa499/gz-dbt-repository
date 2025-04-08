 



SELECT
  orders_id,
  SUM(shipping_fee + log_cost + log_cost + ship_cost) AS operational_margin
FROM {{ ref("stg_raw__ship") }}
GROUP BY orders_id