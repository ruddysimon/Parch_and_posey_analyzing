-- Write a query that displays the order ID, account ID, and total dollar amount for all the orders, 
-- sorted first by the account ID (in ascending order), and then by the total dollar amount (in descending order).
select id, account_id, total_amt_usd
from orders
group by 1,2
order by 1,3 desc ;

-- Now write a query that again displays order ID, account ID, and total dollar amount for each order,
-- but this time sorted first by total dollar amount (in descending order), and then by account ID (in ascending order).
select id, account_id, total_amt_usd
from orders
group by 1,2
order by 3 desc, 1;

-- Provide a table for all web_events associated with account name of Walmart. There should be three columns. 
-- Be sure to include the primary_poc, time of the event, and the channel for each event. 
-- Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.
select a.primary_poc, we.occurred_at, we.channel, a.name
from accounts as a
inner join web_events as we
on a.id = we.account_id
where a.name like 'Walmart';


-- Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: 
-- the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
select r.name as "region", 
	   sr.name as sales_rep_name,
	   a.name as "account_name"
from regions as r
inner join sales_reps as sr
on sr.region_id =  r.id
inner join accounts as a
on a.sales_rep_id = sr.id
order by 3;


-- Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
-- Your final table should have 3 columns: region name, account name, and unit price.
-- A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.
select r.name as "region_name", a.name as "account_name", o.total_amt_usd/(o.total+0.01) as "unit_price"
from sales_reps as sr
inner join regions as r
on r.id = sr.region_id
inner join accounts as a
on a.sales_rep_id = sr.id
inner join orders as o
on a.id = o.account_id
order by 3 asc


-- Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table. 
-- This should give a dollar amount for each order in the table.
select (standard_amt_usd + gloss_amt_usd) as "total_standard_gloss"
from orders;


-- Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.
select a.name, o.occurred_at
from accounts as a
inner join orders as o
on a.id = o.account_id
group by 1,2
order by 2 asc
limit 1;