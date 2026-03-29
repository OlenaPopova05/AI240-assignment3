-- what products bring the most value
select
    product_name,
    max(cumulative_product_revenue) as total_revenue
from fct_order_items
group by product_name
order by total_revenue desc;

-- what categories bring the most value
select
    category_name,
    sum(revenue_after_discount) as total_revenue
from fct_order_items
group by category_name
order by total_revenue desc;

-- revenue loss due to canceled and returned orders
select
    order_status,
    sum(revenue_after_discount) as revenue
from fct_order_items
group by order_status;

-- how often clients come back to place another order on average
select
    avg(order_date - previous_order_date) as avg_days_between_orders
from fct_orders
where previous_order_date is not null;


-- count of orders for each order status
select
    order_status,
    count(*) as total_orders
from fct_orders
group by order_status
order by total_orders desc;

-- payment methods rating
select
    payment_method,
    count(*) as payment_count,
    sum(payment_amount) as total_payment_amount
from fct_payments
group by payment_method
order by total_payment_amount desc;

-- products rating by reviews
select
    product_name,
    avg(rating) as avg_rating,
    count(*) as reviews_count
from fct_reviews
group by product_name
order by avg_rating desc;

-- delivery time rating among the cities
select
    shipping_city,
    avg(delivery_days) as avg_delivery_days,
    count(*) as total_shipments
from fct_shipments
group by shipping_city
order by avg_delivery_days asc;
