 



SELECT
   p.orders_id,
   s.pdt_id,
   s.date_date,
   SUM(p.shipping_fee + p.log_cost + p.ship_cost) AS operational_margin
FROM {{ ref("stg_raw__ship") }} p
INNER JOIN {{ ref("stg_raw__sales") }} s
  ON p.orders_id = s.orders_id
GROUP BY p.orders_id, s.pdt_id, s.date_date