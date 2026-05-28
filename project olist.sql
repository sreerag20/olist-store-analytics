create database project_olist;

use project_olist;

#1 Weekday Vs Weekend (order_purchase_timestamp) Payment Statistics

drop table if exists kpi1;
create table kpi1 
select orders.order_id, orders.order_purchase_timestamp, payment.payment_value, payment.payment_type
from project_olist.olist_orders as orders left join project_olist.olist_order_payments as payment
on orders.order_id= payment.order_id;

select * from kpi1;

select dayname(kpi1.order_purchase_timestamp) from kpi1;

select 
if (dayname(kpi1.order_purchase_timestamp) in ("Sunday", "Saturday") , "Weekend","Weekday") Day_Type
, round(sum(kpi1.payment_value) ,2) Total_Payment from kpi1
group by Day_type;

#2 Number of Orders with review score 5 and payment type as credit card

drop table if exists kpi2;
Create table kpi2
Select  o.order_id , p.payment_type,r.review_score 
from project_olist.olist_orders o 
left join project_olist.olist_order_payments p on 
o.order_id = p.Order_id 
left join project_olist.olist_order_reviews r on 
o.order_id = r.order_id;

select * from kpi2;

select count(kpi2.order_id) Total_orders from kpi2
where payment_type = "credit_card" and review_score = 5;

#3 Average number of days taken for order_delivered_customer_date for pet_shop

drop table if exists kpi3;
create table kpi3
select  o.order_delivered_customer_date, o.order_purchase_timestamp , 
i.product_id,p.product_category_name 
 from project_olist.olist_orders o
 left join project_olist.olist_order_items i on
 o.order_id = i.order_id
 left join project_olist.olist_products p on
 i.product_id = p.product_id;
 
 select * from kpi3;
 
 select avg(datediff(kpi3.order_delivered_customer_date, kpi3.order_purchase_timestamp)) Average_number_of_days from kpi3
 where product_category_name = "pet_shop";
 
 #4 Average price and payment values from customers of sao paulo city
 
 drop table if exists kpi4;
 Create table kpi4
Select o.order_id , c.customer_id ,c.customer_city , i.price, p.payment_value
from project_olist.olist_orders o 
left join project_olist.olist_customer c on 
o.customer_id = c.customer_id 
left join project_olist.olist_order_items i on
o.order_id = i.order_id 
left join project_olist.olist_order_payments p on
o.order_id = p.order_id;

select* from kpi4;

select round(Avg(price),2) Average_Price , Round(Avg(Payment_value),2)  Average_Payment from 
kpi4
where customer_city = "Sao paulo";

#5 Relationship between shipping days (order_delivered_customer_date - order_purchase_timestamp) Vs review scores

drop table if exists kpi5;
create table kpi5
Select o.order_id, o.order_purchase_timestamp , o.order_delivered_customer_date , r.review_score
from project_olist.olist_orders o
left join project_olist.olist_order_reviews r on 
o.order_id = r.order_id ;

select * from kpi5;

Select review_score ,
round( Avg(datediff(order_delivered_customer_date , order_purchase_timestamp)),2) Shipping_Days 
from kpi5
where review_score is not null
group by review_score
order by review_score;

#6 Avg no of days between order_purchase_timestamp and shipping_limit_date for bebes

drop table if exists kpi6;

create table kpi6
select o.order_id, o.order_purchase_timestamp, oi.shipping_limit_date, op.product_category_name
from project_olist.olist_orders o
left join project_olist.olist_order_items oi on
o.order_id = oi.order_id
left join project_olist.olist_products op on 
oi.product_id = op.product_id;

select * from kpi6;

select  avg(kpi6.order_purchase_timestamp - kpi6.shipping_limit_date) as avg_no_of_days
from kpi6
where kpi6.product_category_name = 'bebes' ;

#7 Avg freight_value for seller_city 'rio de janeiro' to customer_city 

drop table if exists kpi7;

create table kpi7
select os.seller_city, oc.customer_city, oi.freight_value
from project_olist.olist_sellers os
left join project_olist.olist_order_items oi on 
os.seller_id = oi.seller_id
left join project_olist.olist_customer oc on 
os.seller_zip_code_prefix = oc.customer_zip_code_prefix;

select* from kpi7;

select kpi7.customer_city, avg(kpi7.freight_value) as avg_freight_value
from kpi7
where kpi7.seller_city = 'rio de janeiro'
group by  kpi7.customer_city;

#8 Relationship between product volume and freight_value

drop table if exists kpi8;

create table kpi8
select op.product_length_cm, op.product_width_cm, op.product_height_cm, oi.freight_value
from project_olist.olist_products op
left join project_olist.olist_order_items oi on 
op.product_id = oi.product_id;

select * from kpi8;
select (kpi8.product_length_cm*kpi8.product_width_cm*kpi8.product_height_cm) as volume_of_product, avg(kpi8.freight_value)
from kpi8
group by kpi8.product_length_cm, kpi8.product_width_cm, kpi8.product_height_cm
order by volume_of_product asc;
