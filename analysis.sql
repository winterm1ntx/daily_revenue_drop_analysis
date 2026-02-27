select count(*) as total_rows,
count(date) as date_not_null,
count(total_items) as total_items_not_null,
count(total_cost) as total_cost_not_null,
count(transaction_id) as transaction_not_null,
count(customer_name) as customer_not_null,
count(city) as city_not_null
from retail_transactions;

with daily_revenue as ( select date(date) as date , sum(total_cost) as revenue
from retail_transactions
group by 1 )
select d.date , d.revenue as revenue_today ,
round(case when y.revenue = 0 then null
else ( d.revenue - y.revenue ) *1.0 / y.revenue *100 end,2) as dod_growth_percent,
round(case when w.revenue = 0 then null
else ( d.revenue - w.revenue ) *1.0 / w.revenue *100 end,2) as wow_growth_percent,
round(avg(d.revenue)over(order by d.date rows between 6 preceding and current row),2) as rolling_avg_7day
from daily_revenue as d
join daily_revenue as y
on y.date = d.date - interval '1 day'
join daily_revenue as w
on w.date = d.date - interval '7 day'
order by 1 ;


with daily_level as ( select date(date) as date , sum(total_cost) / count(distinct transaction_id) as aov , 
count(distinct transaction_id) as volume_order
from retail_transactions
group by 1 )
, daily_summary as ( select d.date , d.volume_order ,
round ( case when y.volume_order = 0 then null
else ( d.volume_order - y.volume_order ) *1.0 / y.volume_order *100 end , 2 ) as dod_growth_order ,
d.aov ,
round ( case when y.aov = 0 then null
else ( d.aov - y.aov ) *1.0 / y.aov *100 end , 2 ) as dod_growth_aov
from daily_level as d
join daily_level as y
on y.date = d.date - interval '1 day'
)
select*
from daily_summary
where date = date '2024-04-18' ;

with total_customer as ( select date(date) as date , count(distinct customer_name) as total_customer
from retail_transactions
group by 1 )
, customer_growth as ( select d.date , d.total_customer , round( case when y.total_customer = 0 then null
else ( d.total_customer - y.total_customer ) * 1.0 / y.total_customer *100 end , 2 ) as dod_growth_customer
from total_customer as d
join total_customer as y
on y.date = d.date - interval '1 day' )
select*
from customer_growth
where date = date '2024-04-18' ;

with first_purchase as (
select customer_name , min(date(date)) as first_purchase_date
from retail_transactions
group by 1 )
, customer_type as ( select date(r.date) as date , r.customer_name , 
case when date(r.date) = f.first_purchase_date then 'New' else 'Returning'
end as customer_type
from retail_transactions as r
join first_purchase as f
on r.customer_name = f.customer_name )
,customer_type_2 as ( select date , customer_type , count(distinct customer_name) as total_customer
from customer_type
group by  1,2 )
, final_query as (
select dct.date , dct.customer_type , dct.total_customer,
case when yct.total_customer = 0 then null
else ( dct.total_customer - yct.total_customer ) *1.0 / yct.total_customer *100 end as dod_growth_type
from customer_type_2 as dct
join customer_type_2 as yct
on yct.date = dct.date - interval '1 day' and dct.customer_type = yct.customer_type )
select*
from final_query
where date = date '2024-04-18'

with first_purchase as (
select customer_name , min(date(date)) as first_purchase_date
from retail_transactions
group by 1 )
, customer_type as ( select date(r.date) as date , r.customer_name , 
case when date(r.date) = f.first_purchase_date then 'New' else 'Returning'
end as customer_type
from retail_transactions as r
join first_purchase as f
on r.customer_name = f.customer_name )
,customer_type_2 as ( select date , customer_type , count(distinct customer_name) as total_customer
from customer_type
group by  1,2 )
, daily_aov_by_type as (
select date(rt.date) as date , ct.customer_type , sum(rt.total_cost) / count(distinct rt.transaction_id) as aov
from retail_transactions as rt
join customer_type as ct
on rt.customer_name = ct.customer_name and date(rt.date) = ct.date
group by 1 ,2 )
, final_query as ( select d.date , d.customer_type , d.aov ,
round ( case when y.aov = 0 then null
else ( d.aov - y.aov ) *1.0 / y.aov *100 end , 2 ) as type_growth_aov
from daily_aov_by_type as d
join daily_aov_by_type as y
on y.date = d.date - interval '1 day' and d.customer_type = y.customer_type )
select *
from final_query
where date = date '2024-04-18'
