create table board (
idx int not null auto_increment,             /* 게시글의 고유번호*/
mid varchar(30) not null,                    /* 게시글 작성자 아이디 */
nickName varchar(20) not null,               /* 게시글 작성자 닉네임 */
title varchar(100) not null,                 /* 게시글 제목 */
content text not null,                       /* 글 내용 */
readNum int default 0,                       /* 글 조회수 */
hostIp varchar(40) not null,                 /* 글 작성자 IP */
openSw char(6) default 'OK',                 /* 게시글 공개 여부 */
wDate datetime default now(),                /* 글 작성 날짜 */
good int default 0,                          /* 좋아요 수 */
complainCnt char(4) default 'NO'						 /* 게시글 신고여부 */
primary key(idx),                            /* 기본 키 : 고유번호 */
foreign key(mid) references member(mid)      /* 외래 키 : 아이디 */ 
); 

insert into board values (default,'admin','관리자','게시판 서비스 시작','게시판 서비스 시작합니다 - 관리자',default,'192.168.50.64','OK',default,default);

desc board;

drop table board;

select * from board;

-- 시간단위, 23이 나오면 작성한지 23시간이 지났다는 것
select *, timestampdiff(hour, wDate, now()) as hour_diff from board;

-- 0은 오늘, -1은 하루 지남
select *, datediff(wDate, now()) as date_diff from board;

select *, timestampdiff(hour, wDate, now()) as hour_diff from board;


select *, datediff(wDate, now()) as date_diff from board;

select idx as nextIdx ,title as nextTitle from board where idx > 5 order by idx limit 1;  -- 다음글
select idx as NextIdx ,title as behindTitle from board where idx < 5 order by idx desc limit 1;  -- 이전글

-- 관리자는 모든글 보여주고, 일반사용자는 비공개글(openSw='NO')과 신고글(complaint='OK')은 볼수없다. 단, 자신이 작성한 글은 볼수 있다.
select count(*) as cnt from board;
select count(*) as cnt from board where openSW = 'OK' and complaint = 'NO';
select count(*) as cnt from board where openSW = 'OK' and complaint = 'NO';
select count(*) as cnt from board where mid = 'hkd1234';

select * from board where openSW = 'OK' and complaint = 'NO';
select * from board where mid = 'hkd1234';
select * from board where openSW = 'OK' and complaint = 'NO' union select * from board where mid = 'hkd1234';
select * from board where openSW = 'OK' and complaint = 'NO' union all select * from board where mid = 'hkd1234';

select count(*) as cnt from board where openSW = 'OK' and complaint = 'NO' union select count(*) as cnt from board where mid = 'hkd1234';
select sum(a.cnt) from (select count(*) as cnt from board where openSW = 'OK' and complaint = 'NO' union select count(*) as cnt from board where mid = 'hkd1234') as a;
select sum(a.cnt) from (select count(*) as cnt from board where openSW = 'OK' and complaint = 'NO' union select count(*) as cnt from board where mid = ?) as a;

select sum(a.cnt) from (select count(*) as cnt from board where openSW = 'OK' and complaint = 'NO' union select count(*) as cnt from board where mid = 'hkd1234' and (openSW = 'NO' or complaint = 'OK')) as a;


select * from board where openSW = 'OK' and complaint = 'NO' union select * from board where mid = 'hkd1234' order by idx desc;



select *, datediff(wDate, now()) as date_diff, timestampdiff(hour, wDate, now()) as hour_diff from board order by idx desc limit 0,10;

/* 댓글 달기 테이블 */
create table boardReply (
idx int not null auto_increment,            /* 댓글 고유번호 */
boardIdx int not null,                      /* 원본글(부모글)의 고유번호[외래키] */
mid varchar(20) not null,                   /* 댓글 작성자 아이디 */
nickName varchar(20) not null,              /* 댓글 작성자 닉네임 */
wDate datetime default now(),               /* 댓글 올린 날짜와 시간 */          
hostIp varchar(50) not null,                /* 댓글 작성한 PC의 고유 IP */   
content text not null,                      /* 댓글 내용 */
primary key(idx),
foreign key(boardIdx) references board(idx)
on update cascade
on delete restrict 
);

desc boardReply;

select * from board;
select * from boardReply;
select * from member;

insert into boardReply values (default,29,'sona123','유소나',default,'192.168.50.69','첫 댓글 테스트!');
insert into boardReply values (default,1,'sona123','유소나',default,'192.168.50.64','첫 글에 댓달고 갑니다~');
insert into boardReply values (default,29,'test2','테스트2',default,'192.168.50.64','첫 댓글 테스트!');


select * from board;
select * from board where mid = 'admin';
desc board;

create view adminview as select * from board where mid = 'admin';

select * from adminview;

show tables;
show full tables in javaclass where table_type like 'view';

drop view adminview;

desc board;
create index nickNameIndex on board(nickName);

show index from board;

alter table board drop index nickNameIndex;

create table board2 (
idx int not null auto_increment,             /* 게시글의 고유번호*/
mid varchar(30) not null,                    /* 게시글 작성자 아이디 */
nickName varchar(20) not null,               /* 게시글 작성자 닉네임 */
title varchar(100) not null,                 /* 게시글 제목 */
content text not null,                       /* 글 내용 */
readNum int default 0,                       /* 글 조회수 */
hostIp varchar(40) not null,                 /* 글 작성자 IP */
openSw char(6) default 'OK',                 /* 게시글 공개 여부 */
wDate datetime default now(),                /* 글 작성 날짜 */
good int default 0,                          /* 좋아요 수 */
complainCnt char(4) default 'NO',					   /* 게시글 신고여부 */
primary key(idx),                            /* 기본 키 : 고유번호 */
foreign key(mid) references member2(mid)      /* 외래 키 : 아이디 */ 
); 

insert into board2 values (default,'admin','관리자','게시판 서비스 시작','게시판 서비스 시작합니다 - 관리자',default,'192.168.50.64','OK',default,default,default);
insert into board2 values (default,'sonaS11','운영자','게시판 서비스 시작','게시판 서비스 시작합니다 - 운영자',default,'192.168.50.64','OK',default,default,default);
insert into board2 values (default,'test1','테스트1','게시판 조항용','게시판 오픈이라니잉!',default,'192.168.50.64','OK',default,default,default);
insert into board2 values (default,'hkd1234','선생님','게시판 서비스 시작 축하해요','게시판 재미있게 꾸며보세요~',default,'192.168.50.20','OK',default,default,default);


desc board2;

drop table board2;

select * from board2;

/* 댓글 달기 테이블 */
create table boardReply2 (
idx int not null auto_increment,            /* 댓글 고유번호 */
boardIdx int not null,                      /* 원본글(부모글)의 고유번호[외래키] */
mid varchar(20) not null,                   /* 댓글 작성자 아이디 */
nickName varchar(20) not null,              /* 댓글 작성자 닉네임 */
wDate datetime default now(),               /* 댓글 올린 날짜와 시간 */          
hostIp varchar(50) not null,                /* 댓글 작성한 PC의 고유 IP */   
content text not null,                      /* 댓글 내용 */
primary key(idx),
foreign key(boardIdx) references board2(idx)
on update cascade
on delete restrict 
);

desc boardReply2;

select * from board2;
select * from boardReply2;
select * from member2;








