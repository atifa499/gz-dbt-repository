



SELECT
p.products_id,
p.purchase_price,
s.date_date,
s.orders_id,
s.revenue,
s.quantity,
(p.purchase_price * s.quantity) AS purchase_cost,
((s.revenue - s.quantity) * p.purchase_price) AS margin
FROM {{ref("stg_raw__product")}} p
JOIN {{ref("stg_raw__sales")}} s
ON p.products_id = s.pdt_id





