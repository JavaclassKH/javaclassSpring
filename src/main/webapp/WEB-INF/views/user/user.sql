create table user (
	idx int not null auto_increment,
	mid varchar(30) not null,
	name varchar(30) not null,
	age int default 20,
	address varchar(15) default '����',
	primary key(idx)
);

insert into user values (default,'admin','������',27,'û��');
insert into user values (default,'sona123','���',32,default);
insert into user values (default,'hkd1234','ȫ�浿',default,default);
insert into user values (default,'kms1234','�踻��',default,'��õ');
insert into user values (default,'lkj1234','�̱���',25,default);

desc user;
select * from user;

select year,sum(robbery) as totRobbery,sum(murder) as totMurder,sum(theft) 
as totTheft,sum(violence) as totViolence,
avg(robbery) as avgRobbery,avg(murder) as avgMurder,avg(theft) 
as avgTheft,avg(violence) as avgViolence
from crime where year = 2022 and police like '����%';

create table user2 (
	mid varchar(4) not null,
	job varchar(10)
);





















