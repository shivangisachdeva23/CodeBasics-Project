SELECT 
     product_name,category,
     ROUND((SUM(CASE
            WHEN promo_type = 'BOGOF' THEN base_price * (`quantity_sold(after_promo)`/ 2)
            WHEN promo_type = '500 Cashback' THEN (base_price - 500) * `quantity_sold(after_promo)`
            WHEN promo_type = '50% OFF' THEN base_price * 0.5 * `quantity_sold(after_promo)`
            WHEN promo_type = '33% OFF' THEN base_price * 0.67 * `quantity_sold(after_promo)`
            WHEN promo_type = '25% OFF' THEN base_price * 0.75 * `quantity_sold(after_promo)` END) - SUM(base_price * `quantity_sold(before_promo)`)) / SUM( base_price * `quantity_sold(before_promo)`)*100,2) AS 'IR%'
     FROM
     fact_events
     JOIN
     dim_products USING (product_code)
     GROUP By product_name,category
     Order By 'IR%' DESC
     LIMIT 5 ; 