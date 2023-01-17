use classicmodels;
alter table customers drop index idx_customerName;
EXPLAIN select * from customers where customerName = 'Land of Toys Inc.';
alter table customers add index idx_customerName(customerName);
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.'; 
select * from customers;
DELIMITER //
create procedure findAllCustomers()
begin
	select * from customers;
end //
DELIMITER ;
delimiter //
drop procedure if exists findAllCustomers//
call findAllCustomers;

delimiter //
create procedure GetCustomersCountByCity(
	in in_city varchar(50),
    out total int
)
begin
	select count(customerNumber)
    from customers
    where city = in_city;
end//
delimiter ;
	call GetCustomersCountByCity('Lyon', @total);
	select @total;
    
delimiter //
create procedure SetCounter(
	inout counter int,
    in inc int
)
begin
	set counter = counter + inc;
end //
delimiter ;

set @counter = 1;
call SetCounter(@counter,1);
select  @counter;

CREATE VIEW customer_views AS
SELECT customerNumber, customerName, phone
FROM  customers;

select * from customer_views;
