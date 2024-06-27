create table pds (
idx int not null auto_increment,               /* 자료실 글 고유번호 */
mid varchar(30) not null,                      /* 작성자 아이디 */
nickName varchar(30) not null,                 /* 작성자 닉네임 */
fName varchar(300) not null,                   /* 유저가 업로드한 파일명 */
fsName varchar(300) not null,                  /* 서버에 저장되는 파일명 */ 
fSize int not null,                            /* 업로드되는 파일의 총 사이즈 */
title varchar(100) not null,                   /* 업로드 파일의 간단 제목 */
part varchar(20) not null,                     /* 파일분류(학습/여행/음식 등) */
fDate datetime default now(),                  /* 파일 업로드한 날짜 */
downNum int default 0,                         /* 파일을 다운로드 받은 횟수 */
openSw char(4) default '공개',                  /* 파일 공개여부(공개/비공개) */
pwd varchar(100),                              /* 파일 비공개시 암호설정 (sha256암호화) */
hostIp varchar(30) not null,                   /* 업로드한 클라이언트 IP */
content text,                                  /* 업로드 파일의 상세 설명 */
primary key(idx),
foreign key(mid) references member(mid)
);

-- 리뷰 테이블
create table review (
idx int not null auto_increment,         /* 리뷰 고유번호 */
part varchar(20) not null,               /* 리뷰 분류(게시판:board, 자료실: pds .....) */
partIdx int not null,                    /* 해당 분류의 고유번호 */
mid varchar(30) not null,                /* 리뷰 작성자의 아이디 */
nickName varchar(30) not null,           /* 리뷰 작성자의 닉네임 */
star int not null default 0,             /* 리뷰 점수(별점) */
content text,                            /* 리뷰 내용 */
rDate datetime default now(),            /* 리뷰등록일자 */
primary key(idx),
foreign key(mid) references member(mid)
);


-- 리뷰 답글 테이블
create table reviewReply (
replyIdx int not null auto_increment,                    /* 원본 글(리뷰)의 고유번호 */
reviewIdx int not null,
replyMid varchar(30) not null,             /* 답글 작성자의 아이디 */
replyNickName varchar(30) not null,        /* 답글 작성자의 닉네임 */
replyRDate datetime default now(),         /* 답글 올린 날짜 */ 
replyContent text not null,                /* 답글 내용 */
primary key(replyIdx),
foreign key(replyMid) references member(mid),
foreign key(reviewIdx) references review(idx)
);

















