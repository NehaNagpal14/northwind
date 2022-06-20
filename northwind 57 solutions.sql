-- beginers level
use northwind_db;
-- ans 1
select* from shippers;

-- ans 2
select * from categories;
select category_name, description from categories;

-- ans 3
select * from employees;
select first_name, 
last_name, hire_date from employees where title = 'sales representative';

-- ans 4
select first_name, 
last_name, hire_date from employees where title = 'sales representative' and country ='USA';

-- ans 5
select * from orders;
select order_id, order_date from orders where employee_id=5;

-- ans 6
select * from suppliers;
select supplier_id, 
contact_name, contact_title from suppliers where contact_title != 'marketing manager';

-- ans 7
select * from products;
select product_id, product_name from products where product_name like '%queso%';

-- ans 8
select * from orders;
select order_id, customer_id, ship_country 
from orders 
where ship_country ='france' or ship_country= 'belgium';

-- ans 9
select * from orders;
select order_id, customer_id, ship_country 
from orders 
where ship_country in ('brazil','mexico','argentina','venezuela');

-- ans 10
select * from employees;
select first_name,
last_name, title, 
birth_date from employees order by birth_date ;

-- ans 11
use northwind_db;
select first_name,
last_name, title, 
birth_date from employees order by birth_date ;

-- ans 12
select first_name, 
last_name, 
concat(first_name,'  ', last_name) as fullname 
from employees;

-- ans 13
select order_id,
product_id, unit_price,
quantity,
unit_price*quantity as TotalPrice from order_details
order by order_id, product_id;


-- ans 14
select count(*) from customers;
select count(customer_id) from customers;

-- ans 15
select* from orders;
select order_date from orders limit 1;

-- ans 16
select * from customers;
select distinct country from customers;

-- ans 17
select * from customers;
select contact_title, -- aggregator
count(contact_title) as Total_contact_title -- aggregated value
from customers
group by contact_title
order by Total_contact_title desc;

-- ans 18

-- ans 19
select * from shippers;

-- intermediate problems
-- ans 20
select * from categories;

-- ans 21
select * from customers;
select country,-- aggregator
city, -- aggregator
count(city) as TotalCustomers -- aggregated value
from customers group by country, city
order by TotalCustomers desc;

-- ans 22
use northwind_db;
select * from products;
select product_id,
product_name, units_in_stock,
reorder_level from products
where units_in_stock < reorder_level;

-- ans 23
select product_id,
product_name, units_in_stock, units_on_order,
reorder_level, discontinued from products
where units_in_stock + units_on_order <= reorder_level
and discontinued= 0;

-- ans 24

-- ans 25
select * from orders;
select ship_country,
avg(freight) from orders
group by ship_country 
order by avg(freight) desc
limit 3;

-- ans 26
select ship_country, 
avg(freight) from orders
where year(order_date)= 2015
group by ship_country 
order by avg(freight) desc;