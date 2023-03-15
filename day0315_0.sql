-- ppt 23페이지 table
-- table 생성 (person): 번호, 이름, 나이, 성별, 지역, 현재날짜
CREATE TABLE PERSON (
    NUM NUMBER(3) PRIMARY KEY,
    NAME VARCHAR2(15) NOT NULL,
    AGE NUMBER(3),
    GENDER VARCHAR2(10) DEFAULT '남자',
    CITY VARCHAR2(15) DEFAULT '서울',
    TODAY DATE
);

-- 데이터 조회
SELECT * FROM PERSON;

-- INSERT 컬럼데이터 일부만 추가할 경우
INSERT INTO PERSON (NUM, NAME, TODAY) VALUES (1, '아무개', SYSDATE);

-- PK(PRIMARY KEY), NN(NOT NULL) 이 경우 값을 안넣어주면 오류발생-확인
INSERT INTO PERSON (NAME, AGE, TODAY) VALUES ('이무개', 23, '2022-10-10'); -- 오류
-- NN 속성이 들어간 컬럼은 무조건 넣어줘야한다, 이번에는 NUM에 같은 데이터를 넣어보자
INSERT INTO PERSON (NUM, NAME, AGE, TODAY) VALUES (1, '이무개', 23, '2022-10-10'); -- 무결성 제약 조건 오류
-- 오류없이 나오도록 제대로 넣어보자
INSERT INTO PERSON (NUM, NAME, AGE, TODAY) VALUES (2, '이무개', 23, '2022-10-10');
-- 일부 컬럼이 아니라 순서대로 모든 컬럼값을 넣을경우 컬럼명 생략 가능
INSERT INTO PERSON VALUES (3, '박무개', 34, '여자', '제주도', '2021-12-21');
-- 각각 7개 정도 추가해보자
INSERT INTO PERSON VALUES (4, '김무개', 15, '여자', '부산', '2023-05-19');
INSERT INTO PERSON VALUES (5, '엄무개', 43, '여자', '마산', '2021-05-31');
INSERT INTO PERSON VALUES (6, '단무개', 24, '남자', '인천', '2016-06-27');
INSERT INTO PERSON VALUES (7, '나무개', 34, '남자', '부천', '2018-08-22');
INSERT INTO PERSON VALUES (8, '권무개', 64, '여자', '전주', '2014-11-08');
INSERT INTO PERSON VALUES (9, '류무개', 18, '여자', '광주', '2011-10-04');
INSERT INTO PERSON VALUES (10, '안무개', 22, '남자', '춘천', '2009-04-30');
COMMIT;
-- 류무개의 AGE, CITY 수정
UPDATE PERSON SET AGE=26, CITY='제주도' WHERE NAME = '류무개';
-- 홍길동의 나이 수정
UPDATE PERSON SET AGE=42 WHERE NAME = '홍길동';
-- 엄무개의 TODAY를 현재 날짜로 수정
UPDATE PERSON SET TODAY = SYSDATE WHERE NAME = '엄무개';
COMMIT;
-- DELETE: WHERE 조건을 전체 모두 삭제됨
DELETE FROM PERSON;
-- 다시 살리기
ROLLBACK;
-- 조건을 이용해서 삭제
DELETE FROM PERSON WHERE NAME = '홍길동';
-- 나이가 30세 미만인 경우 삭제
DELETE FROM PERSON WHERE AGE < 30;
ROLLBACK;

-- 지금부터는 테이블 구조를 수정하는 연습
-- 테이블에 컬럼 추가
ALTER TABLE PERSON ADD SCORE NUMBER(3) DEFAULT 50;

-- 방금 추가한 SCORE 컬럼을 제거
ALTER TABLE PERSON DROP COLUMN SCORE;

-- 컬럼 타입 수정
ALTER TABLE PERSON MODIFY CITY VARCHAR2(20);

-- 컬럼명 변경 TODAY -> IPSADAY 로 변경
ALTER TABLE PERSON RENAME COLUMN TODAY TO IPSADAY;

-- 제약 조건을 제거: NAME에 NOT NULL 제약조건이 들어있다(제약조건이름을 안줘서 기본 이름으로 들어가있다)
-- SYS_C008320 제거
ALTER TABLE PERSON DROP CONSTRAINT SYS_C008320;

-- PPT 30페이지
-- NAME에 새로운 제약조건을 추가해보자(UNIQUE)
ALTER TABLE PERSON ADD CONSTRAINT PERSON_UQ_NAME UNIQUE(NAME);

-- 이름에 같은 이름을 넣으면 이제 오류가 발생
-- ORA-00001: 무결성 제약 조건(ANGEL.PERSON_UQ_NAME)에 위배됩니다
INSERT INTO PERSON (NUM, NAME) VALUES (11, '박무개');

-- GENDER에 '남자', '여자' 외의 데이터를 넣으면 오류가 발생하도로 CHECK 제약조건을 추가해보자
ALTER TABLE PERSON ADD CONSTRAINT PERSON_CK_GENDER CHECK (GENDER IN ('남자', '여자'));

-- AGE 예 10-50세만 추가 가능하도록 제약 조건을 추가
ALTER TABLE PERSON ADD CONSTRAINT PERSON_CK_AGE CHECK (AGE >= 10 AND AGE <= 70);

-- 문제1
-- PK 제약조건을 제거후 PERSON_PK_NUM 이라는 새로운 제약조건을 추가해보자
ALTER TABLE PERSON DROP CONSTRAINT SYS_C008321;
ALTER TABLE PERSON ADD CONSTRAINT PERSON_PK_NUM PRIMARY KEY(NUM);

-- 문제2
-- BUSEO라는 컬럼을 추가 VARCHAR2(10)의 기본값을 '교육부'
ALTER TABLE PERSON ADD BUSEO VARCHAR2(10) DEFAULT '교육부';
-- BUSEO에 제약조건 추가 '교육부', '홍보부', '인사부' 3개만 추가 가능하도록
ALTER TABLE PERSON ADD CONSTRAINT PERSON_CK_BUSEO CHECK (BUSEO IN ('교육부', '홍보부', '인사부'));

-- 문제3
-- 박씨, 이씨 성을 가진 사람들은 모두 '인사부'로 수정
UPDATE PERSON SET BUSEO = '인사부' WHERE NAME LIKE '박%' OR NAME LIKE '이%';
-- 김씨, 나씨 성을 가진 사람들을 모두 '홍보부'로 수정
UPDATE PERSON SET BUSEO = '홍보부' WHERE NAME LIKE '김%' OR NAME LIKE '나%';

-- 문제4
-- 남자 여자 성별로 인원수와 평균나이(정수타입) 구하기
SELECT GENDER, COUNT(*), AVG(AGE) FROM PERSON GROUP BY GENDER ORDER BY 2 DESC;
-- 부서별로 인원수와 평균나이 구하기
SELECT BUSEO, COUNT(*), ROUND(AVG(AGE), 0) FROM PERSON GROUP BY BUSEO ORDER BY BUSEO;

-- 시퀸스 생성하는 방법 PPT 78페이지
-- 가장 많이 사용하는 기본 시퀸스: 1부터 1씩 증가하는 시퀸스
CREATE SEQUENCE SEQ1;
CREATE SEQUENCE SEQ2 START WITH 1 INCREMENT BY 1; -- 위와 같다
CREATE SEQUENCE SEQ3 START WITH 10 INCREMENT BY 5 NOCACHE; -- NOCACHE: CACHE를 0으로
CREATE SEQUENCE SEQ4 MAXVALUE 100; -- MAX값이 100까지만 발생된다.

-- 시퀸스 조회
SELECT * FROM SEQ;
 -- 테이블 조회
SELECT * FROM TAB;

-- 시퀸스 제거
DROP SEQUENCE SEQ2;
DROP SEQUENCE SEQ4;

-- 다음 값 발생 NEXTVAL, 현재값 CURRVAL
SELECT SEQ1.NEXTVAL, SEQ3.NEXTVAL FROM DUAL; -- 반복해서 실행
SELECT SEQ1.NEXTVAL, SEQ3.CURRVAL FROM DUAL; -- 마지막 발생한 값