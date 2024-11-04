
-- NOT Operator

select * from customer;


--will give all records excluding 'guna'
select * from customer where not cname='guna';

-- using with AND,OR
select * from customer where NOT cname='guna' OR not city='hyd';
select * from customer where NOT cname='guna' AND not city='ptp';

-- we can use <>

select * from customer where city<>'bngl';