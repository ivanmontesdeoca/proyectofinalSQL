create schema update_delete_cascade;
use update_delete_cascade ;

create table person(personId bigint(12) primary key,
name varchar(20),age int(3));

drop table if exists orders ;
create table orders(orderId bigint(12) primary key,
orderName varchar(20),
personId bigint(20) ,
foreign key(personId) references person(personId)
ON DELETE SET NULL ); 
-- ON DELETE SET NULL: est

insert into person values(1,"vasu",26);
insert into person values(2,"Ayush",26);
insert into person values(3,"sushmits",25);
 
insert into orders values(1,"Shoes", 1);
insert into orders values(2,"Jeans", 1);
insert into orders values(3,"Tshirt", 3);
insert into orders values(4,"Jacket",2 );

create table pais(paisId bigint(12) primary key,
paisname varchar(20)
ON UPDATE SET null
-- ON UPDATE CASCADE
); 

create table provincia(provinciaId bigint(12) primary key,
provincianame varchar(20),
foreign key(paisId) references pais(paisId)
ON UPDATE SET null
-- ON UPDATE CASCADE
);

insert into pais values(1,"vasu",26);
insert into pais values(1,"vasu",26);
insert into pais values(1,"vasu",26);
 
insert into orders values(1,"Shoes", 1);
insert into orders values(2,"Jeans", 1);
insert into orders values(3,"Tshirt", 3);
insert into orders values(4,"Jacket",2 )
