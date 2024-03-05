Select p.product_name, p.product_code from 
dim_products p join fact_events e on p.product_code = e.product_code
where base_price > 500 and promo_type = "BOGOF"
group by p.product_code,p.product_name;
