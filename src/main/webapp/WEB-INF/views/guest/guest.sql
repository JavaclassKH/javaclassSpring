select * from hoewon;

create table guest2(
idx int not null auto_increment primary key, /* 방명록 고유번호 */
name varchar(30) not null, /* 방명록 작성자 이름 */
content text not null, /* 방명록 글 내용 */
email varchar(70), /* 메일주소(필수X) */
homepage varchar(70), /* 자기 페이지 주소(필수X) */
visitDate datetime default now(), /* 방문일자 */
hostIp varchar(40) not null /* 방문자의 접속 IP */
);

insert into guest2 values (default,'관리자','스프링 더미더미','kkkkdkdkd@jdnfnsdf.com','java',default,'192.168.50.64');