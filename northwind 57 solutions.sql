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

-- ans 27
select ship_country, 
avg(freight) from orders
where order_date between '1997-01-01' and '1998-12-01' 
group by ship_country 
order by avg(freight) desc
limit 3;

-- ans 28
select max(order_date) from orders;
select ship_country, 
avg(freight) from orders
where order_date between '1997-05-06' and '1998-05-06' 
group by ship_country 
order by avg(freight) desc
limit 3;

-- ans 29
-- employees and orders would join on employee_id
-- orders and order_details would join on order_id
-- order_details and products would join on product_id
select  employees.employee_id,
last_name,
orders.order_id, product_name,
quantity from employees 
left join orders on
employees.employee_id = orders.employee_id
left join order_details on
orders.order_id = order_details.order_id
left join products on
order_details.product_id = products.product_id;

-- ans 30
select customers.customer_id,
orders.customer_id as order_placed from customers
left join orders on
customers.customer_id = orders.customer_id
 where orders.customer_id is null;

-- ans 31
select customers.customer_id,
orders.customer_id as order_placed
from customers
left join orders on
customers.customer_id = orders.customer_id
and employee_id = 4
 where orders.customer_id is null ;

-- ans 32
select customers.customer_id,
company_name, orders.order_id,
sum(quantity* unit_price) as total_price from customers
left join orders on
customers.customer_id = orders.customer_id
left join order_details on
orders.order_id = order_details.order_id
where order_date >= '19970101' and order_date < '19980101'
group by customers.customer_id, 
company_name, orders.order_id
having total_price > 10000 ; 
 
-- ans 33
select customers.customer_id,
company_name, -- order_details.order_id,
sum(quantity* unit_price) as total_price from customers
left join orders on
customers.customer_id = orders.customer_id
left join order_details on
orders.order_id = order_details.order_id
where order_date >= '19970101' and order_date < '19980101'
group by customers.customer_id,
company_name -- order_details.order_id
having total_price >= 15000
order by total_price desc ; 
 
-- ans 34
use northwind_db;

-- ans 35
select employee_id,
order_id,                -- not done yet 
order_date from orders
where order_date('1996-10-28', interval 1 month);

-- ans 36
select order_id,
count(order_id) from order_details
group by order_id
order by count(order_id) desc
limit 10;

-- ans 37

-- ans 38
select order_id,
quantity
 from order_details
where quantity >=60;

-- ans 39
select *
 from order_details
where quantity >=60;

-- ans 41
select order_id,
order_date,
required_date,
shipped_date from orders
where shipped_date >= required_date;

-- ans 42
select * from orders; 
select  employee_id, count(employee_id) from orders
where shipped_date >= required_date
group by employee_id
order by count(employee_id) desc;

-- ans 43
select employees.employee_id,
last_name,
count(orders.employee_id) as total_orders from EMPLOYEES
left join orders
on employees.employee_id = orders.employee_id                 -- incomplete         
group by employee_id, last_name;

-- ans 44
-- ans 45
-- ans 46
-- ans 47

-- ans 48
with cte as(
select customers.customer_id,
company_name,
sum(unit_price*quantity) as total_orders from customers
left join orders on
customers.customer_id = orders.customer_id
left join order_details
on orders.order_id = order_details.order_id
where order_date >= '1997-01-01'
and order_date <= '1997-12-31'
group by customers.customer_id,
company_name)
select customer_id,
company_name,
 total_orders,
case
    when total_orders between 0 and 1000  then 'low'
   when total_orders between 1001 and 5000  then 'medium'
   when total_orders between 5001 and 10000  then 'high'
    else 'very high'
    end customer_group
from cte
order by customer_id;

-- ans 49
with cte as(
select customers.customer_id,
company_name,
sum(unit_price*quantity) as total_orders from customers
left join orders on
customers.customer_id = orders.customer_id
left join order_details
on orders.order_id = order_details.order_id
where order_date >= '1997-01-01'
and order_date <= '1997-12-31'
group by customers.customer_id,
company_name)
select customer_id,
company_name,
 total_orders,
case
    when total_orders >= 0 and total_orders <1000  then 'low'
   when total_orders >= 1000 and total_orders < 5000 then 'medium'
   when total_orders >= 5000 and total_orders < 10000 then 'high'
   when total_orders >= 10000 then 'very high'
   else 'null' end customer_group
from cte
order by customer_id;

-- ans 50
-- ans 51
-- ans 52
select country from suppliers
union
select country from customers
order by country;

-- ans 53
