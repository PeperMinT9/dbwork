drop table if exists stu;

create table stu(
	num smallint auto_increment primary key,
    name varchar(20) not null,
    score smallint,
    today1 date,
    today2 datetime
);

select * from stu;

-- 컬럼 일부만 데이터 추가하기
insert into stu (name, score, today1, today2) values ('이무개', 89, now(), now());
-- 컬럼명 생략시 num에도 값을 넣어줘야하는데 null 값 넣으면 시퀸스가 알아서 들어간다
insert into stu values (null, '김무개', 79, now(), now());
-- 삭제
delete from stu where name = '이무개';
delete from stu where name = '김무개';
-- 데이터 추가
insert into stu values (null, '아무개', 79, now(), now());
insert into stu values (null, '이무개', 62, now(), now());
insert into stu values (null, '김무개', 87, now(), now());
insert into stu values (null, '권무개', 52, now(), now());
insert into stu values (null, '홍무개', 41, now(), now());

select date_format(now(), '%Y-%m-%d') today from dual; -- 2023-03-16
select date_format(now(), '%y-%M-%d') today from dual; -- %y: 년도 2자리 %M: 문자열로
select date_format(now(), '%Y-%m-%d %H:%i') today from dual; -- %H: 24시간 %i: 분

-- stu 데이터 출력
select num, name, score, date_format(today2, '%Y-%m-%d %H:%i') today from stu;

-- insert - score 빼고
insert into stu (name, today2) values ('강무개', now());
insert into stu (name, today2) values ('나무개', now());

select name, ifnull(score, 50) score from stu;

-- age를 smallint로 추가하는데 기본값을 10살로 추가alter
alter table `stu` add `age` smallint default 10; 
-- today1 컬럼을 제거
alter table `stu` drop `today1`;
-- name을 varchar(30)로 수정
alter table `stu` change `name` `name` varchar(30);
-- today2를 birthday로 수정
alter table `stu` change `today2` `birthday` datetime;