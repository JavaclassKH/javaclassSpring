show tables;

create table crime (
idx int not null auto_increment primary key,            /*  */
year int not null,                                      /* 강력범죄 발생년도 */
police varchar(30) not null,                            /* 경찰서 */
robbery int,                                            /* 강도 건 수 */   
theft int,                                              /* 절도 건 수 */
murder int,                                             /* 살인 건 수 */
violence int                                            /* 폭력 건 수 */
);

select * from crime;
