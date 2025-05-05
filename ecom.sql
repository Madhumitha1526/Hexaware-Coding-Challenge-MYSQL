-- database creation --
create database ecom;
use ecom;

-- creating tables --

create table customers(
customer_id int primary key,
first_name varchar(200) not null,
last_name varchar(200) not null,
email varchar(20) default 'abc@gmail.com',
password varchar(20) not null
);

create table products(
product_id int primary key,
name varchar(200) not null,
price decimal(10,2),
description varchar(255),
stockQuantity int not null
);

create table cart(
cart_id int primary key,
customer_id int not null,
product_id int not null,
quantity int not null,
constraint fk_cart_cusid foreign key (customer_id) references customers(customer_id) on delete cascade,
constraint fk_cart_prodid foreign key (product_id) references products(product_id) on delete cascade
);

create table orders(
order_id int primary key ,
customer_id int not null,
order_date date not null,
total_price decimal(10,2) not null,
shipping_address varchar(255) not null,
constraint fk_orders_cusid foreign key (customer_id) references customers(customer_id) on delete cascade
);

create table order_items(
order_item_id int primary key,
order_id int not null,
product_id int not null,
quantity int not null,
constraint fk_orderitem_orderid foreign key (order_id) references products(product_id) on delete cascade,
constraint fk_orderitem_prodid foreign key (product_id) references products(product_id) on delete cascade
);

alter table customers change email email varchar(200);

-- inserting values into the table--

insert into customers values
(1, 'John', 'Doe', 'johndoe@example.com', 'pwd1'),
(2, 'Jane', 'Smith', 'janesmith@example.com', 'pwd2'),
(3, 'Robert','Johnson', 'robert@example.com', 'pwd3'),
(4, 'Sarah','Brown', 'sarah@example.com', 'pwd4'),
(5, 'David', 'Lee', 'david@example.com', 'pwd5'),
(6, 'Laura', 'Hall', 'laura@example.com', 'pwd6'),
(7, 'Michael', 'Davis', 'michael@example.com', 'pwd7'),
(8, 'Emma' , 'Wilson', 'emma@example.com', 'pwd8'),
(9, 'William','Taylor', 'william@example.com', 'pwd9'),
(10, 'Olivia','Adams', 'olivia@example.com', 'pwd10');

select * from customers;

insert into products values
(1, 'Laptop', 800.00, 'High-performance laptop', 10),
(2, 'Smartphone', 600.00, 'Latest smartphone', 15),
(3, 'Tablet', 300.00, 'Portable tablet', 20),
(4, 'Headphones', 150.00, 'Noise-canceling', 30),
(5, 'TV', 900.00, '4K Smart TV', 5),
(6, 'Coffee Maker', 50.00, 'Automatic coffee maker', 25),
(7, 'Refrigerator', 700.00, 'Energy-efficient', 10),
(8, 'Microwave Oven', 80.00, 'Countertop microwave', 15),
(9, 'Blender', 70.00, 'High-speed blender', 20),
(10, 'Vacuum Cleaner', 120.00, 'Bagless vacuum cleaner', 10);

select * from products;

insert into cart values 
(1, 1, 1, 2), 
(2, 1, 3, 1), 
(3, 2, 2, 3), 
(4, 3, 4, 4),
(5, 3, 5, 2), 
(6, 4, 6, 1), 
(7, 5, 1, 1), 
(8, 6, 10, 2),
(9, 6, 9, 3), 
(10, 7, 7, 2);

select * from cart;

insert into orders values
(1, 1, '2023-01-05', 1200.00, '123 Main St'),
(2, 2, '2023-02-10', 900.00, '456 Elm St'),
(3, 3, '2023-03-15', 300.00, '789 Oak St'),
(4, 4, '2023-04-20', 150.00, '101 Pine St'),
(5, 5, '2023-05-25', 1800.00, '234 Cedar St'),
(6, 6, '2023-06-30', 400.00, '567 Birch St'),
(7, 7, '2023-07-05', 700.00, '890 Maple St'),
(8, 8, '2023-08-10', 160.00, '321 Redwood St'),
(9, 9, '2023-09-15', 140.00, '432 Spruce St'),
(10, 10, '2023-10-20', 1400.00, '765 Fir St');

select * from orders;

insert into order_items values
(1, 1, 1, 2), 
(2, 1, 3, 1),
(3, 2, 2, 3), 
(4, 3, 5, 2),
(5, 4, 4, 4), 
(6, 4, 6, 1),
(7, 5, 1, 1), 
(8, 5, 2, 2),
(9, 6, 10, 2), 
(10, 6, 9, 3);

select * from order_items;

-- altering the items by updating fields --

alter table products add category ENUM('Devices', 'Home Appliances') not null default 'Devices';
update products set category = 'Devices' where name in('Smartphone', 'Laptop', 'Tablet','Headphones','TV');
update products set category = 'Home Appliances' where name in('Coffee Maker', 'Refrigerator','Microwave Oven','Blender','Vacuum Cleaner');

alter table order_items add column ItemAmount decimal(10, 2) not null default 0.00;

update order_items
set ItemAmount = 
    case order_item_id
        when 1 then 1600.00
        when 2 then 300.00
        when 3 then 1800.00
        when 4 then 1800.00
        when 5 then 600.00
        when 6 then 50.00
        when 7 then 800.00
        when 8 then 1200.00
        when 9 then 240.00
        when 10 then 210.00
    end;

select * from order_items;

select * from products;

/*---------------------------------------------------------------------------------------------------------------------*/

-- SQL Qureies --

-- 1. Update refrigerator product price to 800 --
update products set price=800.00 where product_id=7 and name= "Refrigerator";
select * from products;

-- 2. Remove all the cart items for a specific row --
delete from cart where customer_id = 6;
select * from cart;

-- 3. Retrieve products priced below $100 --
select * from products where price<100;

-- 4. Products with Stock Quantity greater than 5 --
select * from products where Stockquantity>5;

-- 5. Orders with total amount between $100 and $1000 --
select * from orders where total_price between 100.00 and 1000.00 order by customer_id;

-- 6. Find products which name ends with letter 'r' --
select * from products where name like '%r';

-- 7.Retrieve cart items for customer 5;
select * from cart where customer_id=5;

-- 8. Customer who placed orders in 2003 --
select * from customers c 
join orders o on c.customer_id = o.customer_id 
where year(order_date)=2023;

-- 9. Minimum stock quantity for each product category --
select category, min(StockQuantity) as minimum_stock_quantity
from products
group by category;

-- 10. Total Amount spent by each customer --
select c.customer_id,concat(c.first_name,'',c.last_name) as name, sum(o.total_price) as total_amount_spent
from customers c
join orders o on c.customer_id=o.customer_id
group by c.customer_id,name;

-- 11. Average order amount for each customer--
select c.customer_id,concat(c.first_name,'',c.last_name) as name,avg(o.total_price) as average_order
from customers c
join orders o where c.customer_id=o.customer_id
group by c.customer_id, name;

-- 12. Number of orders placed by each customer --
select o.customer_id, concat(c.first_name,'',c.last_name) as name, count(*) as order_count 
from orders o
join customers c on o.customer_id - c.customer_id
group by o.customer_id, name;

-- 13.Maxinmum order amount for each customer--
select o.customer_id, concat(first_name,'',c.last_name) as name, max(total_price) as maximum_order_amount
from orders o
join customers c on o.customer_id=c.customer_id
group by o.customer_id, name;

-- 14. customers who placed orders totaling over $1000
select c.customer_id,concat(first_name,'',c.last_name) as name , sum(o.total_price) as total_spent
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id,name
having total_spent > 1000;

-- 15. products which are not in the cart --
select * from products 
where product_id not in (select distinct product_id from cart);

-- 16. customers who haven't placed orders--
select * from customers
where customer_id not in (select distinct customer_id from orders);

-- 17. percentage of total revenue for a product--
select p.product_id, p.name,
       round(sum(oi.ItemAmount) * 100.0 / (select sum(ItemAmount) from order_items), 2) as total_revenue_percentage
from products p
join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.name;

-- 18. products with low stock less than 5 --
select * from products
where product_id in (select product_id from products where stockquantity < 5);

-- 19. customers who placed high-value orders greater than 1000 --
select * from customers c
where exists (select 1 from orders o where o.customer_id = c.customer_id and o.total_price > 1000);






