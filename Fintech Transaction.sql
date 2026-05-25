create database fintech_db;
use fintech_db;
show databases;
show tables;
select * from transactions;
select * from compliance_flags;
select * from merchant;
select * from fx_rates;
-- which currency drives the most volumn on the platform
select currency, count(*) as total_transaction,
sum(amount) as total_amount, avg(amount)
from transactions
group by currency
order by total_amount desc;

-- what percentage of transactions are failing
select status, count(*) as total,
round(count(*) * 100 / sum(count(*)) over(),2) as percentage
from transactions
group by status
order by total desc;

-- which transaction types carry highest fraud
select transaction_type, count(*) as total_transactions,
sum(is_fraud), round(sum(is_fraud) * 100 / count(*),2) as fraud_percent
from transactions
group by transaction_type
order by total_transactions;

-- most valuable merchants
select m.merchant_name, m.business_type, 
m.country, count(t.transaction_id) as total_transaction,
sum(t.amount) as total_amount from transactions t
join merchant m 
on t.merchant_id = m.merchant_id
group by m.merchant_name, m.business_type, m.country
order by total_amount desc;

-- Full data of every flagged transaction
select t.transaction_id, m.merchant_id, m.merchant_name,
m.business_type, f.flag_id, f.flag_type, f.flag_reason,
f.flagged_at, f.resolved
from merchant m
join transactions t
on t.merchant_id = m.merchant_id
join compliance_flags f
on t.transaction_id = f.transaction_id
order by f.flagged_at;

-- How many compliance issue are still opened?
select flag_type, count(*) as total_flags,
sum(case when resolved = 0 then 1 else 0 end) as unresolved,
sum(case when resolved = 1 then 1 else 0 end) as resolved
from compliance_flags
group by flag_type
order by unresolved desc;

-- which currency pairs are most volatile
select base_currency, target_currency,
avg(rate) as Average_rate,
max(rate) as highest_rate,
min(rate) as minimum_rate,
round((max(rate) - min(rate)),3) as range_volatility,
round(stddev(rate),3) as std_volatility
from fx_rates
group by base_currency, target_currency
order by range_volatility desc;

-- Daily transaction trend
select date_format(created_at, "%m-%d") as daily_transaction,
count(*) as total_transactions,
sum(amount) as total_volumn,
sum(is_fraud) as total_fraud
from transactions
group by daily_transaction
order by daily_transaction desc;

-- full health score for every merchant
select m.merchant_name,
m.business_type, m.country,
count(t.transaction_id) as total_transaction,
sum(t.amount) as total_volumn,
sum(t.is_fraud) as total_fraud,
round(sum(t.is_fraud) * 100 / count(*),2) as fraud_percent,
count(f.flag_id) as compliance_flags
from merchant m
join transactions t 
on m.merchant_id = t.merchant_id
join compliance_flags f
on t.transaction_id = f.transaction_id
group by m.merchant_name, m.business_type, m.country
order by fraud_percent;

-- high risk transaction
select t.transaction_id, t.amount, t.currency, t.transaction_type,
t.status, t.is_fraud, m.merchant_name, m.business_type,
m.country,f.flag_type, f.flag_reason
from merchant m 
join transactions t
on m.merchant_id = t.merchant_id
left join compliance_flags f
on t.transaction_id = f.transaction_id
where t.is_fraud = 1 or f.resolved = 0
order by t.amount desc;

