-- sawon에 제약조건 추가하기
-- score는 0~100aks 추가가능하도록 제약조건 추가
alter table sawon drop constraint shop_pk_score;
alter table sawon add constraint sawon_pk_score check(score between 0 and 100);
-- gender에 '남자', '여자'만 가능하도록 check 제약조건 추가
alter table sawon add constraint sawon_ck_gender check (gender in ('남자', '여자'));

-- mysql에서 제약조건 확인하기
select * from information_schema.table_constraints where table_name = 'sawon';
desc sawon;

-- 데이터 추가
insert into sawon values (null, '이무개', 78, '여자', '홍보부');
insert into sawon (name, score, gender) VALUES ('강무개', 89, '남자');
UPDATE sawon SET name = '이무개' WHERE num = 1;
UPDATE sawon SET name = '강무개' WHERE num = 2;
insert into sawon values (null, '박무개', 78, '남자', '인사부');
insert into sawon values (null, '아무개', 78, '여자', '교육부');
insert into sawon values (null, '진무개', 78, '여자', '인사부');

UPDATE sawon SET score = 52 WHERE num = 3;

UPDATE sawon SET score = 12 WHERE num = 4;

UPDATE sawon SET score = 88 WHERE num = 5;

SELECT * FROM sawon;

-- 쿼리문 연습하기
select count(*) from sawon;
-- 강씨 성을 가진 사람의 인원수 구하기
select count(*) from sawon WHERE name like '강%';

-- 평균 점수보다 높은 사람 출력하기
select * from sawon WHERE score > (select AVG(score) from sawon);

-- 부서별 인원수와 평균점수 최고점수 최저점수 구하기
select buseo as 부서명, count(*) as 인원수, round(avg(score), 1) as 평균점수, max(score) as 최고점수, min(score) as 최저점수 from sawon GROUP BY buseo;

-- 인사부에서 이씨성을 가진 사람이 누가 있는지 출력
select count(*) from sawon WHERE (name like '박%' and buseo = '인사부');

-- 이무개의 부서를 '교육부'로 수정
update sawon set buseo = '교육부' where name = '이무개';

-- join 연습할 서브 테이블 생성 sawoninfo idx, num(외부키), addr, pn, age 
-- 부모테이블 데이터 삭제시 데이터 자동삭제하려면 제약조건 뒤에 on delete cascade 추가
create table sawoninfo (
  idx SMALLINT PRIMARY key AUTO_INCREMENT,
  num SMALLINT,
  addr VARCHAR(30),
  pn varchar(20),
  age SMALLINT,
  constraint info_fk_num FOREIGN KEY(num) REFERENCES sawon(num)
);

desc sawoninfo;

select * from information_schema.table_constraints where table_name = 'sawoninfo';

-- 데이터 추가
insert sawoninfo VALUES (null, 1, '강남구', '010-1412-5451', 35);
insert sawoninfo VALUES (null, 2, '강서구', '010-7451-6241', 26);
insert sawoninfo VALUES (null, 4, '강동구', '010-7342-1235', 28);
insert sawoninfo VALUES (null, 5, '마포구', '010-9786-7345', 44);
insert sawoninfo VALUES (null, 6, '동작구', '010-3453-6785', 21);

-- sawoninfo만 데이터 출력
select * FROM sawoninfo;

-- sawon 테이블과 join으로 사원정보 모두 출력
-- join 방법 1
select sawon.num, name, gender, buseo, age, pn, addr, score 
  from sawon, sawoninfo as info where sawon.num = info.num;

-- 컬럼명 대신에 * 가능
select * from sawon, sawoninfo as info where sawon.num = info.num;

-- join 방법 2
select sawon.num, name, gender, buseo, age, pn, addr, score 
  from sawon inner join sawoninfo on sawon.num = sawoninfo.num;

-- left outer join
select sawon.num, name, gender, buseo, age, pn, addr, score 
  from sawon LEFT OUTER join sawoninfo on sawon.num = sawoninfo.num;

-- right outer join
select sawon.num, name, gender, buseo, age, pn, addr, score 
  from sawon RIGHT OUTER join sawoninfo on sawon.num = sawoninfo.num;

-- on delete cascade: sawon에서 2번 데이터 삭제시 sawoninfo에서도 삭제됨
-- 아직 안줌
-- 문제 기존 외부키 제약조건 제거하고 다시 준다(on delete casecade 추가)
alter table sawoninfo drop constraint info_fk_num;
alter table sawoninfo add constraint info_fk_num FOREIGN KEY(num) references sawon(num) on delete CASCADE;

delete from sawon where num = 2;
select * from sawon, sawoninfo as info where sawon.num = info.num;

SELECT buseo, count(*) as count, round(avg(score), 1) as avgscore,
  max(score) as maxscore, min(score) as minscore from sawon GROUP BY buseo;

CREATE Table bitcamp (
  seq_no int PRIMARY KEY AUTO_INCREMENT,
  name varchar(5),
  java int,
  spring int,
  pub_date DATE
);

insert bitcamp VALUES (null, "이무개", 76, 32, "2023-02-11");
insert bitcamp VALUES (null, "아무개", 31, 33, "2023-03-21");
insert bitcamp VALUES (null, "김무개", 76, 88, "2023-03-18");
insert bitcamp VALUES (null, "박무개", 46, 57, "2023-01-26");
insert bitcamp VALUES (null, "정무개", 73, 23, "2023-07-05");
insert bitcamp VALUES (null, "진무개", 43, 57, "2023-06-09");
insert bitcamp VALUES (null, "엄무개", 63, 35, "2023-10-12");
insert bitcamp VALUES (null, "한무개", 65, 68, "2023-08-02");
insert bitcamp VALUES (null, "권무개", 48, 34, "2023-01-01");
insert bitcamp VALUES (null, "강무개", 41, 86, "2023-12-31");

alter table bitcamp add CONSTRAINT bitcamp_ck_java check(java between 1 and 100);
alter table bitcamp add CONSTRAINT bitcamp_ck_spring check(spring between 1 and 100);
select * from information_schema.table_constraints where table_name = 'bitcamp';

-- 1번 전체출력
select *, (java + spring) as sum, ROUND(((java + spring) / 2), 1) as avg from bitcamp;
-- 2번 이름검색
select *, (java + spring) as sum, ((java + spring) / 2) as avg from bitcamp WHERE name = '이무개';
-- 3번 평균검색
select * from bitcamp WHERE (java + spring) > (SELECT (AVG(java) + AVG(spring)) from bitcamp);
-- select ROUND(AVG(java), 1) as javaScore, ROUND(AVG(spring), 1) as springScore from bitcamp WHERE (java + spring) > (SELECT (AVG(java) + AVG(spring)) from bitcamp);
SELECT (AVG(java) + AVG(spring)) from bitcamp;

select gender, count(*) as count, round(avg(score), 1) as avg from sawon group by gender;
select buseo, count(*) as count, round(avg(score), 1) as avg from sawon group by buseo;
select * from sawon;
