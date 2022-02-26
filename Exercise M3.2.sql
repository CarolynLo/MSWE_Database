/*1*/
create index zip_code_index on  vendors(vendor_zip_code);

/*2*/
Drop table if exists committees;
CREATE TABLE committees (
	committee_id INT primary key unique not null,
    committee_name VARCHAR(45) not null
);
Drop table if exists members;
create table members(
	member_id INT primary key unique not null,
    first_name VARCHAR(45) not null,
    last_name VARCHAR(45) not null,
    address VARCHAR(45),
    city VARCHAR(45),
    state VARCHAR(45),
    phone VARCHAR(45)
);
Drop table if exists members_committees;
create table members_committees(
	member_id INT not null,
    committee_id INT not null,
    foreign key(member_id) references members(member_id),
    foreign key(committee_id) references committees(committee_id)
);

/*3*/
insert into members(member_id, first_name, last_name)
value(1, 'Apple', 'King');
insert into members(member_id, first_name, last_name)
value(2, 'Orange', 'County');
insert into committees
value(11, 'fruits_committees');
insert into committees
value(22, 'food_committees');
insert into members_committees(member_id,committee_id)
value(1,11);
insert into members_committees(member_id,committee_id)
value(2,22);
select c.committee_name, m.last_name, m.first_name
from members m
	join members_committees mc
		on m.member_id = mc.member_id
    join committees c
		on mc.committee_id = c.committee_id
order by c.committee_name asc, m.last_name asc, m.first_name asc;

/*4*/
alter table members
add column annual_dues decimal(5,2) default 52.50;
alter table members
add column payment_date date;

/*5*/
alter table committees
add constraint unique(committee_name);
insert into committees
value(33,'food_committees');
