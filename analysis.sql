select count(*) as total_rows,
count(date) as date_not_null,
count(total_items) as total_items_not_null,
count(total_cost) as total_cost_not_null,
count(transaction_id) as transaction_not_null,
count(customer_name) as customer_not_null,
count(city) as city_not_null
from retail_transactions;

with daily_revenue as ( select date(date) as date , sum(total_items*total_cost) as revenue
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
order by 1

with daily_summary as (
select date , volume_order , revenue *1.0 / volume_order as aov , lag(volume_order)over(order by date) as previous_volume_order , 
lag(revenue *1.0 / volume_order)over(order by date) as previous_aov
from (
select date(date) as date , sum(total_items*total_cost) as revenue , count(distinct transaction_id) as volume_order
from retail_transactions
group by 1 ))
select date , volume_order , 
round(case when previous_volume_order = 0 then null
else ( volume_order - previous_volume_order ) *1.0 / previous_volume_order *100 end,2) as dod_growth_order,
aov,
round(case when previous_aov = 0 then null
else ( aov - previous_aov ) *1.0 / previous_aov *100 end,2) as dod_growth_aov
from daily_summary
where date = date '2024-05-18'

with customer_summary as ( select date , total_customer , 
round(case when lag(total_customer)over(order by date) = 0 then null 
else ( total_customer - lag(total_customer)over(order by date) ) *1.0 /lag(total_customer)over(order by date) *100 end,2) as dod_growth_customer
from ( select date(date) as date , count(distinct customer_name) as total_customer 
from retail_transactions
group by 1 ) )
select*
from customer_summary
where date = date '2024-05-18'

with city_summary as ( select* , round(case when lag(total_transaksi)over(partition by city order by date) = 0 then null
else ( total_transaksi - lag(total_transaksi)over(partition by city order by date) ) *1.0 / lag(total_transaksi)over(partition by city order by date) * 100 end , 2 ) as city_dod_growth
from (
select date(date) as date , city , count(distinct transaction_id) as total_transaksi
from retail_transactions
group by 1 , 2 ))
select *
from city_summary
where date = date '2024-04-18'
