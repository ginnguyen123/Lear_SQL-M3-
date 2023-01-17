use classicmodels;
alter table customers drop index idx_customerName;
EXPLAIN select * from customers where customerName = 'Land of Toys Inc.';
alter table customers add index idx_customerName(customerName);
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.'; 