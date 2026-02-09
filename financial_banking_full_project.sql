select column_name, data_type from information_schema.columns 
where table_name = 'client_info'; -- this will give the datatype of a column client_info

--data transaction-- 

select * from transactions; 

-- 2016 data change to 2017, 2017-2018,2018-2019,2019-2020,2020-2021,2021-2022,2022-2023.
-- correction in transaction table-- 

select date + interval '1 year' from transactions; -- temperory update--

update transactions 
set date = date + interval '1 year';

select * from transactions;

select distinct extract(year from date) as year from transactions; 



select * from transactions;

rollback; 

select * from transactions; 

select distinct extract(year from date) as year from transactions; 

update transactions
set date = date - interval '108 year'; 

select * from transactions;

select distinct extract(year from date) as year from transactions; 

select count(*) from transactions 
where extract(year from date) = 2017 and bank is null;

select extract(year from date) as years, count(*) as null_count from transactions
where bank is null
group by extract(year from date);


update transactions 
set bank = 'Northern Bank' where extract(year from date) = 2019 and bank is null;

update transactions 
set bank = 'DBS Bank' where extract(year from date) = 2021 and bank is null;

update transactions 
set bank = 'Sky Bank' where extract(year from date) = 2022 and bank is null;


-- card table tranforation-- 

select * from card;

select extract(year from issued) as year ,count(*) from card
group by extract(year from issued)
order by year;

-- 1 year interval--

update card 
set issued = issued - interval '1 year'; 

-- create age group of clients -- with the help of last transaction date , so the diffrence btween birth_date
-- and last_transaction date you can remove age of client and then create age_group-- 


select * from client_info; 

update client_info
set birth_date = birth_date - interval '23 year';

select max(date) into LTD from  transactions;  -- max date = 2022-12-19 -- 

alter table client_info
add column age int;

select * from client_info;

update client_info
set age = extract(year from age(date '2022-12-19',birth_date)); 

select * from client_info 
order by client_info; 


-- Ad-hoc Data Analysis -- 
--1. What is the demographic profile of the bank's clients and how does it vary across districts?

-- district wise how  many male & female client are there in bank 

select * from district;

select * from client_info 
order by client_info;

select avg(age) from client_info; -- 43.718569
select round(avg(age),0) from client_info; -- 44


create table if not exists czez_demographic_profile_kpi_ as
select c.district_id, d.district_name, d.average_salary,
round(avg(c.age),0) as avg_age,    -- because when calculate avg_age it will give into point thats why used round
sum(case when c.sex = 'Female' then 1 else 0 end) as Female_client,
sum(case when c.sex = 'Male' then 1 else 0 end) as Male_client,
count(distinct client_id) as total_client,
round((sum(case when sex = 'Female' then 1 else 0 end)::NUMERIC/
       nullif(sum(case when sex = 'Male' then 1 else 0 end),0)) * 100 , 2) as male_female_ratio_perc
from client_info c
inner join district d on c.district_id = d.district_id
group by c.district_id, d.district_name, d.average_salary; 

select * from czez_demographic_profile_kpi_; 

-- 2. How the banks have performed over the years. Give their detailed analysis year & month-wise.

-- this query will give you the last transaction date of each month for every customer and then it will tell you
-- final balance.

create table if not exists c 
as 
select ltd. *, txn.balance
from transactions as txn
inner join
(
  select account_id, extract(year from date) as txn_year,
  extract(month from date) as txn_month,
  max(date) as latest_txn_date
  from transactions
  group by 1,2,3
  order by 1,2,3 --inner query which will give to last transaction date
) as ltd on txn.account_id = ltd.account_id and txn.date = ltd.latest_txn_date
where txn.type = 'Credit' -- this is the assumption am having : month end txn data is credit
order by txn.account_id, ltd.txn_year,ltd.txn_month; -- outer query will give you on the credited data 

select * from acc_latest_txns_with_balance;
 
select * from transactions;

-- 3. What are the most common types of accounts and how do they differ in terms of usage and profitability?

select * from account; --account_type
select * from transactions; -- calculate usage

create table if not exists account_usage_profitability 
as
select a.account_type, count(t.trans_id) as total_transactions,
sum(t.amount) as total_transaction_amount, 
sum(
   case
       when t.type = 'Credit' then t.amount -- credit
       when t.type = 'Debit' then -t.amount -- for debit
	   else 0 
	   end) as profit 
from account a
join transactions t
on a.account_id = t.account_id
group by a.account_type
order by total_transactions desc; 

select * from account_usage_profitability; 


--4. Which types of cards are most frequently used by the bank's clients and what is the 
-- overall profitability of the credit card business?
select * from account; -- card_assigned , account_id
select * from transactions; -- account_id

create table if not exists credit_card_profitability_kpi_ as
select a.card_assigned,
count(t.trans_id) as transaction_count,
sum(t.amount) as total_transaction_amount
from account a
join transactions t
on a.account_id = t.account_id
group by card_assigned
order by transaction_count desc;  -- silver(962231)

select * from credit_card_profitability_kpi_;


-- 5. What are the major expenses of the bank and how can they be reduced to improve profitability?
select * from loan;
select * from transactions;
select * from account;
select * from card;
select * from acc_latest_txns_with_balance;

drop table if exists bank_expense_kpi;

create table if not exists bank_expense_kpi 
as 
select count(distinct t.trans_id) as total_transactions,
count(distinct a.account_id) filter(where al.balance < 0) as low_balance_account, --filter balance less than 0
count(distinct l.loan_id) filter(where l.status = 'Loan not paid') as default_loan,--filters client who have not paid loan
count(distinct c.card_id) as active_cards from account a -- filter active_cards
join transactions t
on a.account_id = t.account_id
join acc_latest_txns_with_balance al
on a.account_id = al.account_id
join loan l
on a.account_id = l.account_id
join card c
on c.type = a.card_assigned;


select * from bank_expense_kpi;









