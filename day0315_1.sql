-- 문제
-- 테이블 생성(student): num 숫자(5), name 문자열(10), height 숫자(5, 1),
-- java 숫자(3) 기본값 10, spring 숫자(3) 기본값 10, ban 문자열(20)
CREATE TABLE STUDENT (
    NUM NUMBER(5),
    NAME VARCHAR2(10),
    HEIGHT NUMBER(5, 1),
    JAVA NUMBER(3) DEFAULT 10,
    SPRING NUMBER(3) DEFAULT 10,
    BAN VARCHAR2(20)
);

DROP TABLE STUDENT;

-- 시퀸스 생성 seq_stu 기본(1부터 1씩증가), nocache 추가
CREATE SEQUENCE SEQ_STU START WITH 1 INCREMENT BY 1 NOCACHE;

DROP SEQUENCE SEQ_STU;

-- 제약조건들 추가
-- num에 primary key 추가
ALTER TABLE STUDENT ADD CONSTRAINT STUDENT_PK_NUM PRIMARY KEY(NUM);
-- java, spring 은 1~100만 가능하도록 check 제약 조건 추가
ALTER TABLE STUDENT ADD CONSTRAINT STUDENT_CK_JS CHECK (JAVA >= 1 AND JAVA <= 100 AND SPRING >= 1 AND SPRING <= 100);
-- ban은 '1반', '2반', '3반'만 추가할수 있도록 check 추가
ALTER TABLE STUDENT ADD CONSTRAINT STUDENT_CK_BAN CHECK (BAN IN ('1반', '2반', '3반'));

-- 5개 정도만 데이터를 추가해보 자
insert into student (num, name, java, height, ban) VALUES (SEQ_STU.NEXTVAL, '아무개', 37, 167.5, '1반');
insert into student VALUES (SEQ_STU.NEXTVAL, '이무개', 167.5, 62, 23, '2반');
insert into student VALUES (SEQ_STU.NEXTVAL, '김무개', 145.8, 75, 65, '3반');
insert into student VALUES (SEQ_STU.NEXTVAL, '박무개', 194.2, 63, 41, '2반');
insert into student VALUES (SEQ_STU.NEXTVAL, '한무개', 161.9, 90, 88, '1반');

-- NUM이 3인 사람의 JAVA점수를 99로, BAN을 '2반'으로
UPDATE STUDENT SET JAVA = 99, BAN = '2반' WHERE NUM = 3;
-- NUM이 5 인사람의 키를 188.9로 수정
UPDATE STUDENT SET HEIGHT = 188.9 WHERE NUM = 5;
-- NUM = 2 인 데이터 삭제
DELETE FROM STUDENT WHERE NUM = 2;
-- 조회 이름 반 자바 스프링 총점 평균 - 총점이 높은사람부터 출력
SELECT NAME, BAN, JAVA, SPRING, (JAVA + SPRING) AS SUM, (JAVA + SPRING)/2 AS AVG FROM STUDENT ORDER BY (JAVA + SPRING) DESC;

COMMIT;

-- DB 정규화(Normalization)
-- 정규화란 한마디로 DB서버의 메모리를 낭비하지 않기 위해서 어떤 테이블을 식별자를 가지는 여러개의 테이블로 나누는 과정
-- 정규화된 DB는 중복이 최소화되도록 설계된 데이터베이스이다
-- 장점: 메모리를 절약할 수 있다. 구조화된 시스템으로 인해서 관리가 편하다
-- 단점: 조회비율이 매우 높은 시스템의 경우에는 테이블간의 JOIN연산이 반복적으로 이뤄지기 때문에 질의 응답 속도가 느려진다

-- STUDENT의 NUM을 외부키로 갖는 새로운 테이블 STUINFO를 만들어보자
-- 외부키는 테이블 생성시 설정해도 되고 일단 생성후 테이블 수정으로 추가해도 된다

-- PPT 29페이지
CREATE TABLE STUINFO (
    IDX NUMBER(5) CONSTRAINT INFO_PK_IDX PRIMARY KEY,
    NUM NUMBER(5),
    ADDR VARCHAR2(20),
    PN VARCHAR2(15)
);


-- 외부키 제약조건 추가
-- STUINFO의 NUM은 STUDENT의 NUM값만 넣을 수 있도록 설정
ALTER TABLE STUINFO ADD CONSTRAINT INFO_FK_NUM FOREIGN KEY(NUM) REFERENCES STUDENT(NUM);

-- STUINFO의 NUM에 만약 3을 추가했다면 STUDENT테이블에서 NUM = 3인 데이터는 삭제할 수 없다
-- 단 제약조건 추가시 ON DELETE CASCADE를 추가했을경우 부모테이블의 NUM = 3인 데이터 삭제시 STUINFO의 NUM 3 인 데이터는 자동 삭제된다

-- STUINFO에 데이터 추가하기
INSERT INTO STUINFO VALUES (SEQ_STU.NEXTVAL, 3, '서울시 강남구', '010-2222-3333');
-- STUINFO에 없는 2번을 추가해보자
-- ORA-02291: 무결성 제약조건(ANGEL.INFO_FK_NUM)이 위배되었습니다- 부모 키가 없습니다
INSERT INTO STUINFO VALUES (SEQ_STU.NEXTVAL, 2, '서울시 강남구', '010-2222-3333');
-- 다시 4번으로
INSERT INTO STUINFO VALUES (SEQ_STU.NEXTVAL, 4, '서울시 강동구', '010-3333-2222');
INSERT INTO STUINFO VALUES (SEQ_STU.NEXTVAL, 1, '대구시 중구', '010-4444-5555');
COMMIT;

-- 조회
-- 각각 조회를 할겨우 모든 정보를 알수없다
SELECT * FROM STUINFO;

-- JOIN으로 두 테이블을 합해서 필요한 정보를 가져와보자
-- PPT 43페이지
-- INNER JOIN 또는 EQUI JOIN 이라고 한다. 서로 NUM값이 같을경우에만 가져온다
SELECT SD.NUM 시퀀스, SD.NAME AS 학생명, SD.HEIGHT AS 키, SD.BAN AS 반, 
    SI.ADDR AS 주소, SI.PN AS 핸드폰, SD.JAVA 자바, SD.SPRING 스프링
    FROM STUDENT SD, STUINFO SI WHERE SD.NUM = SI.NUM;
    
-- 이때 양쪽 테이블에 공통적으로 갖고 있는 컬럼을 제외하고는 앞에 테이블명 생략 가능
SELECT SD.NUM 시퀀스, NAME AS 학생명, HEIGHT AS 키, BAN AS 반, 
    ADDR AS 주소, PN AS 핸드폰, JAVA 자바, SPRING 스프링
    FROM STUDENT SD, STUINFO SI WHERE SD.NUM = SI.NUM;
    
-- outer join 으로 추가되지 않은 데이터를 찾아보자
-- sub 테이블쪽에 (+)
-- 이때 양쪽 테이블에 공통적으로 갖고 있는 컬럼을 제외하고는 앞에 테이블명 생략 가능
SELECT SD.NUM 시퀀스, NAME AS 학생명, HEIGHT AS 키, BAN AS 반, 
    ADDR AS 주소, PN AS 핸드폰, JAVA 자바, SPRING 스프링
    FROM STUDENT SD, STUINFO SI WHERE SD.NUM = SI.NUM(+) and addr is null;
    
-- student 테이블의 num = 1인 데이터 삭제해보자
-- ORA-02292: 무결성 제약조건(ANGEL.INFO_FK_NUM)이 위배되었습니다- 자식 레코드가 발견되었습니다
-- 이 경우 만약 살제를 하고싶으면 stuinfo의 데이터를 먼저 삭제후 student의 데이터를 삭제할수있다.
delete from student where num = 1;

-- sub 테이블의 num = 1 먼저 삭제후 부모테이블의 num = 1을 삭제해보자
delete from stuinfo where num = 1;
delete from student where num = 1;

-- 테이블 제거시 서브테이블을 먼저 제거후 부모 테이블 제거
drop table stuinfo;
drop table student;

---------------------------------------------------------------------------------------------------

-- 이번에는 부모테이블의 데이터 삭제시 서브테이블의 데이터도 자동으로 삭제되도록
-- 외부키를 설정해보자
-- 시퀸스 설정
CREATE SEQUENCE SEQ_SHOP;
-- SHOP, CART
CREATE TABLE SHOP (
    SANG_NO NUMBER(3) CONSTRAINT SHOP_PK_NO PRIMARY KEY,
    SANG_NAME VARCHAR2(30),
    SANG_PRICE NUMBER(10)
);

-- 외부키 설정시 ON DELETE CASCADE를 붙이면 부모테이블 삭제시 자식테이블에 추가됨 데이터도 같이 삭제됨
CREATE TABLE CART (
    CART_NO NUMBER(3) CONSTRAINT CART_PK_NO PRIMARY KEY,
    SANG_NO NUMBER(3),
    CNT NUMBER(3),
    CARTDAY DATE,
    CONSTRAINT CART_FK_NO FOREIGN KEY(SANG_NO) REFERENCES SHOP(SANG_NO) ON DELETE CASCADE
);

-- 5개의 상품을 등록해보자
INSERT INTO SHOP VALUES (SEQ_SHOP.NEXTVAL, '블라우스', 12000);
INSERT INTO SHOP VALUES (SEQ_SHOP.NEXTVAL, '바지', 18000);
INSERT INTO SHOP VALUES (SEQ_SHOP.NEXTVAL, '점퍼', 87000);
INSERT INTO SHOP VALUES (SEQ_SHOP.NEXTVAL, '패딩', 99000);
INSERT INTO SHOP VALUES (SEQ_SHOP.NEXTVAL, '코트', 120000);
COMMIT;

INSERT INTO CART VALUES (SEQ_SHOP.NEXTVAL, 2, 3, SYSDATE);
INSERT INTO CART VALUES (SEQ_SHOP.NEXTVAL, 3, 1, '2021-01-13');
INSERT INTO CART VALUES (SEQ_SHOP.NEXTVAL, 5, 3, SYSDATE);
COMMIT;

-- 조회
-- SANG_NO 상품번호, 상품명, 단가, 수량, 구입일(년4-월2-일2 형식으로 출력)
SELECT SH.SANG_NO AS 상품번호, SANG_NAME AS 상품명, TO_CHAR(SANG_PRICE, 'l999,999') AS 단가, 
    CNT AS 수량, TO_CHAR(CARTDAY, 'YYYY-MM-DD') AS 구입일
    FROM SHOP SH, CART CA WHERE SH.SANG_NO = CA.SANG_NO;
-- CART에 담기지 않은 상품의 상품번호와 상품명 출력
SELECT SH.SANG_NO AS 상품번호, SANG_NAME AS 상품명 
    FROM SHOP SH, CART CA WHERE SH.SANG_NO = CA.SANG_NO(+) AND CNT IS NULL;
    
-- 삭제시 확인(2, 3, 5 상품이 CART에 담겨있음)
-- SHOP의 2번, 3번 상품을 삭제후 CART 테이블을 확인
DELETE FROM SHOP WHERE SANG_NO = 2 OR SANG_NO = 3;
SELECT * FROM CART;

-- 오늘 연습한 모든 테이블과 시퀸스를 제거해주세요
DROP SEQUENCE SEQ_SHOP;
DROP SEQUENCE SEQ_STU;
DROP SEQUENCE SEQ1;
DROP SEQUENCE SEQ3;
DROP SEQUENCE SEQ4;
DROP TABLE CART;
DROP TABLE SHOP;
DROP TABLE PERSON;
COMMIT;

------------------------------------------------------------------------------------------------

CREATE SEQUENCE SEQ_FOOD START WITH 1 INCREMENT BY 1;

CREATE TABLE RESTAURANT (
    FOOD_NUM NUMBER(3) CONSTRAINT RESTAURANT_PK_NO PRIMARY KEY,
    FOOD_NAME VARCHAR2(30),
    FOOD_PRICE NUMBER(7)
);

CREATE TABLE RESORDER (
    ORDER_NUM NUMBER(3) CONSTRAINT RESORDER_PK_NO PRIMARY KEY,
    ORDER_NAME VARCHAR2(20),
    FOOD_NUM NUMBER(3),
    ORDER_DAY DATE,
    JUMUN_DAY DATE,
    INWON NUMBER(3),
    CONSTRAINT RESORDER_FK_NO FOREIGN KEY(FOOD_NUM) REFERENCES RESTAURANT(FOOD_NUM) ON DELETE CASCADE
);

--DROP SEQUENCE SEQ_FOOD;
--DROP TABLE RESORDER;
--DROP TABLE RESTAURANT;

INSERT INTO RESTAURANT VALUES (SEQ_FOOD.NEXTVAL, '스파게티', 23000);
INSERT INTO RESTAURANT VALUES (SEQ_FOOD.NEXTVAL, '새우볶음밥', 11000);
INSERT INTO RESTAURANT VALUES (SEQ_FOOD.NEXTVAL, '전복죽', 19000);
INSERT INTO RESTAURANT VALUES (SEQ_FOOD.NEXTVAL, '새우튀김', 10000);
INSERT INTO RESTAURANT VALUES (SEQ_FOOD.NEXTVAL, '짜장면', 5000);

INSERT INTO RESORDER VALUES (SEQ_FOOD.NEXTVAL, '이무개', 1, '2023-11-20', SYSDATE, 4);
INSERT INTO RESORDER VALUES (SEQ_FOOD.NEXTVAL, '강무개', 2, '2023-12-25', SYSDATE, 3);
INSERT INTO RESORDER VALUES (SEQ_FOOD.NEXTVAL, '강무개', 3, '2023-12-20', SYSDATE, 3);
INSERT INTO RESORDER VALUES (SEQ_FOOD.NEXTVAL, '이무개', 1, '2023-05-11', SYSDATE, 2);

SELECT ORDER_NAME AS 주문자, ORDER_DAY AS 예약일, RS.FOOD_NAME AS 음식명,
    RS.FOOD_PRICE AS 음식가격, TO_CHAR(JUMUN_DAY, 'YYYY-MM-DD') AS 주문일, INWON AS 인원수
    FROM RESTAURANT RS, RESORDER RO WHERE RS.FOOD_NUM = RO.FOOD_NUM;
    
DELETE FROM RESTAURANT WHERE FOOD_NAME = '전복죽';

SELECT * FROM RESTAURANT;
SELECT * FROM RESORDER;