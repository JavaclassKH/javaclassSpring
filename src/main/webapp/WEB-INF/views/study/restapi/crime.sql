show tables;

create table crime (
idx int not null auto_increment primary key,            /*  */
year int not null,                                      /* ���¹��� �߻��⵵ */
police varchar(30) not null,                            /* ������ */
robbery int,                                            /* ���� �� �� */   
theft int,                                              /* ���� �� �� */
murder int,                                             /* ���� �� �� */
violence int                                            /* ���� �� �� */
);

select * from crime;
