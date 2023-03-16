-- PLSQL 연습용 테이블과 연습용 시퀸스 생성
CREATE SEQUENCE SEQ_TEST NOCACHE; -- 1부터 증가하는 시퀸스
CREATE TABLE SHOP (
    NUM NUMBER(3) CONSTRAINT SHOP_PK_NUM PRIMARY KEY,
    SANGPUM VARCHAR2(30),
    SU NUMBER(3),
    DAN NUMBER(7),
    TODAY DATE
);

--DROP SEQUENCE SEQ_TEST;
--DROP TABLE SHOP;

-- 기본 데이터 5개
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL, '청바지', 2, 19000, SYSDATE);
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL, '통바지', 1, 21000, SYSDATE);
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL, '솜바지', 1, 23000, SYSDATE);
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL, '겹바지', 3, 27000, SYSDATE);
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL, '면바지', 2, 32000, SYSDATE);
COMMIT;

-- PL-SQL: SQL 언어에 절차적 요소를 추가해서 프로그래밍한것을 PL SQL 이라고 한다
-- 형식
-- DECLARE
-- 변수선언, 커서선언
-- BEGIN
-- 각종 출력 또는 로직들
-- DBMS_OUT.PUT_PUT_LINE(); 한줄출력 명령어
-- END;

-- SET SERVEROUTPUT ON 콘솔창에 결과값 나오게하기
-- SET SERVEROUTPUT OFF 콘솔창에 결과값 안나오게
SET SERVEROUTPUT OFF

DECLARE
    V_NO NUMBER(4, 1); -- 4자리 숫자, 소숫점이하 1자리
BEGIN
    V_NO := 10;
    DBMS_OUTPUT.PUT_LINE('숫자는'||V_NO||'입니다'); 
END;
 
-- SHOP 테이블에서 특정 상품정보 얻어오기
DECLARE
    V_SNAGPUM VARCHAR2(30);
    V_SANGPUM VARCHAR2(30);
    V_SU NUMBER(3);
    V_DAN NUMBER(7);
    V_NUM NUMBER(3) := 3; -- 검색해서 가져올 NUM값
BEGIN
    SELECT SANGPUM, SU, DAN 
    INTO V_SANGPUM, V_SU, V_DAN
    FROM SHOP WHERE NUM = V_NUM;
    DBMS_OUTPUT.PUT_LINE(V_NUM||'번 상품설명');
    DBMS_OUTPUT.PUT_LINE('상품명: '||V_SANGPUM);
    DBMS_OUTPUT.PUT_LINE('수 량: '||V_SU);
    DBMS_OUTPUT.PUT_LINE('단 가: '||V_DAN);
    DBMS_OUTPUT.PUT_LINE('총금액: '||V_SU * V_DAN);
END;
/

-- SHOP 테이블에서 특정 상품정보 얻어오기
DECLARE
    V_SANGPUM VARCHAR2(30) := '청바지'; -- 검색해서 가져올 SANGPUM값
    V_SU NUMBER(3);
    V_DAN NUMBER(7);
    V_NUM NUMBER(3); 
BEGIN
    SELECT NUM, SU, DAN
    INTO V_NUM, V_SU, V_DAN
    FROM SHOP WHERE SANGPUM = V_SANGPUM;
    DBMS_OUTPUT.PUT_LINE(V_SANGPUM||'상품설명');
    DBMS_OUTPUT.PUT_LINE('시퀸스값: '||V_NUM);
    DBMS_OUTPUT.PUT_LINE('수 량: '||V_SU);
    DBMS_OUTPUT.PUT_LINE('단 가: '||V_DAN);
    DBMS_OUTPUT.PUT_LINE('총금액: '||V_SU * V_DAN);
END;
/

-- 조건문
/*
단일 조건문
    IF 조건식 THEN
        문장1;
    ELSE
        문장2;
    END IF;
    
다중조건문
    IF 조건식1 THEN
        문장1;
    ELSIF 조건식2 THEN
        문장2;
    .......
    END IF;
*/

-- 특정년도가 무슨띠인지 구학
-- 년도를 키보드로 입력받아서 띠를 알아볼수 있도록 수정하기
ACCEPT K_YEAR PROMPT '연도 4자리를 입력해주세요';
DECLARE
    V_YEAR NUMBER(4) := 2023;
    V_MOD NUMBER(2) := MOD(V_YEAR, 12); -- 년도를 12로 나눈 나머지
    V_DDI VARCHAR2(10); -- 띠를 구해서 저장
BEGIN
    IF V_MOD = 0 THEN V_DDI := '원숭이';
    ELSIF V_MOD = 1 THEN V_DDI := '닭';
    ELSIF V_MOD = 2 THEN V_DDI := '개';
    ELSIF V_MOD = 3 THEN V_DDI := '돼지';
    ELSIF V_MOD = 4 THEN V_DDI := '쥐';
    ELSIF V_MOD= 5 THEN V_DDI := '소';
    ELSIF V_MOD = 6 THEN V_DDI := '호랑이';
    ELSIF V_MOD = 7 THEN V_DDI := '토끼';
    ELSIF V_MOD = 8 THEN V_DDI := '용';
    ELSIF V_MOD = 9 THEN V_DDI := '뱀';
    ELSIF V_MOD = 10 THEN V_DDI := '말';
    ELSIF V_MOD = 11 THEN V_DDI := '양';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(V_YEAR||'년 생은'||V_DDI||'입니다'); 
END;
/

-- 숫자를 입력받아 12입력시 12는 짝수입나다, 11입력시 11은 홀수입니다 출력
ACCEPT k_SU PROMPT '정수 4자리 이하 입력';
DECLARE
    V_SU NUMBER(10) := '&K_SU';
    V_RES VARCHAR2(10) := '짝수';
BEGIN
    IF MOD(V_SU, 2) = 1 THEN V_RES := '홀수';
    ELSE V_RES := '짝수';
    
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(V_SU||'은 '||V_RES||'입니다'); 
END;
/

/*
    반복문
    LOOP
        명령들;
        EXIT WITH 조건;
    END LOOP
*/

ACCEPT k_DAN PROMPT '구구단 숫자를 입력해주세요';
DECLARE
    V_DAN NUMBER(3) := '&K_DAN';
    V_IDX NUMBER(1) := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE('** ['||V_DAN||'단] **');
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(V_DAN||' X '||V_IDX||' = '||V_DAN * V_IDX);
        V_IDX := V_IDX + 1;
        EXIT WHEN V_IDX > 9;
    END LOOP;
END;
/

/*
    또 다른 조건문 CASE
    
    변수 :=
        CASE 표현식
            WHEN 값1 THEN 결과1
            WHEN 값2 THEN 결과2
            WHEN 값3 THEN 결과3
            ELSE 결과4
        END;
*/

DECLARE
    V_GRADE CHAR(1) := 'A';
    V_MSG VARCHAR2(15);
BEGIN
    V_MSG :=
        CASE V_GRADE
            WHEN 'A' THEN 'EXCELLENT!!'
            WHEN 'B' THEN 'VERY GOOD!!'
            WHEN 'C' THEN 'GOOD!!'
            ELSE 'TRY!!'
        END;
        DBMS_OUTPUT.PUT_LINE(V_GRADE||'학점은 '||V_MSG);
END;
/

ACCEPT K_SANGPUM PROMPT '가져올 상품명 받아오기';
DECLARE
    V_SANGPUM VARCHAR2(30) := '&K_SANGPUM'; -- 키보드 입력시 가져올 상품명
    V_SU NUMBER(3);
    V_DAN NUMBER(7);
    V_NUM NUMBER(3); 
BEGIN
    SELECT NUM, SU, DAN
    INTO V_NUM, V_SU, V_DAN
    FROM SHOP WHERE SANGPUM = V_SANGPUM;
    DBMS_OUTPUT.PUT_LINE(V_SANGPUM||'상품설명');
    DBMS_OUTPUT.PUT_LINE('시퀸스값: '||V_NUM);
    DBMS_OUTPUT.PUT_LINE('수 량: '||V_SU);
    DBMS_OUTPUT.PUT_LINE('단 가: '||V_DAN);
    DBMS_OUTPUT.PUT_LINE('총금액: '||V_SU * V_DAN);
    
    -- 오라클에서 예외 처리하는 방법
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE(V_SANGPUM||' 상품은 DB에 없습니다!');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('예외 발생!');
END;
/

-- SHOP 테이블 수정
-- SHOP 테이블에 COLOR 컬럼을 추가하고 기본색을 'GREEN'
ALTER TABLE SHOP ADD COLOR VARCHAR2(20) DEFAULT 'GREEN';
-- 3번은 PINK로 수정, 5번은 YELLOW로 수정
UPDATE SHOP SET COLOR = 'PINK' WHERE NUM = 3;
UPDATE SHOP SET COLOR = 'YELLOW' WHERE NUM = 5;
-- 데이터 추가: 중복된 상품명도 넣어보세요
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL, '면바지', 3, 15500, SYSDATE, 'ORANGE');
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL, '통바지', 3, 21000, SYSDATE, 'BLACK');
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL, '반바지', 3, 12000, SYSDATE, 'KARKI');
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL, '반바지', 3, 12000, SYSDATE, 'GRAY');
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL, '겹바지', 3, 33000, SYSDATE, 'BLACK');
COMMIT;

/*
    FOR 반복문
    FOR 변수명 IN [REVERSE] 시작값..최종값 LOOP
        문장들;
    END LOOP;
*/

DECLARE
    V_BDAN NUMBER(5) := '&K_BDAN';
    V_NUM NUMBER(2);
BEGIN
    DBMS_OUTPUT.PUT_LINE(V_BDAN||'단');
    FOR V_NUM IN 1..9 LOOP
        DBMS_OUTPUT.PUT_LINE(V_BDAN||' X '||V_NUM||' = '||V_BDAN * V_NUM);
    END LOOP;
END;
/

-- DB의 타입을 적용하는 방법
-- DB의 데이터를 레크드 단위로 가져오는 방법
DECLARE
    V_SANG SHOP.SANGPUM%TYPE := '청바지'; -- DB의 SANGPUM 타입을 적용
    V_SHOP ANGEL.SHOP%ROWTYPE; -- 레코드단위로 데이터를 읽이 위한 선언
    
BEGIN
    SELECT * 
    INTO V_SHOP
    FROM SHOP
    WHERE SANGPUM = V_SANG;
    
    DBMS_OUTPUT.PUT_LINE('상품명: '||V_SHOP.SANGPUM);
    DBMS_OUTPUT.PUT_LINE('색 상: '||V_SHOP.COLOR);
    DBMS_OUTPUT.PUT_LINE('수 량: '||V_SHOP.SU);
    DBMS_OUTPUT.PUT_LINE('단 가: '||V_SHOP.DAN);
    DBMS_OUTPUT.PUT_LINE('구입일: '||V_SHOP.TODAY);
END;
/

/*
    여러 레코드 조회시
    CURSOR 커서명
    IS
    SELECT 문장; --SELECT 조회의 결과를 CURSOR에 저장
    
    FOR 레코드명 IN 커서명
*/

-- SHOP 전체 데이터 출력
DECLARE
    CURSOR S1
    IS
    SELECT * FROM SHOP ORDER BY DAN DESC;
    
    V_CNT NUMBER(5);
BEGIN
    DBMS_OUTPUT.PUT_LINE('번호    상품명    색상   수량   단가    구입일');
    FOR S IN S1 LOOP
        DBMS_OUTPUT.PUT_LINE(S.NUM||'   '||S.SANGPUM||'   '||S.COLOR||'   '||
            S.SU||'   '||S.DAN||'   '||S.TODAY);
    END LOOP;
    
    SELECT COUNT(*) INTO V_CNT FROM SHOP;
    DBMS_OUTPUT.PUT_LINE('총 '||V_CNT||'개의 상품이 있습니다');
END;
/

/*
    키보드로 상품명 일부를 입력받아 해당 상품들을 출력하시오
    
    만약 상품명을 '바지' 라고 입력시 
    총 N개의 상품이 있습니다
    
    상품명: 청바지
    색상: YELLOW
    단가: 23000
    
    상품명: 반바지
    색상: GRAY
    단가: 15000
    .
    .
    만약 없을 경우 바지 상품은 목록에 없습니다 로 출력
*/
ACCEPT K_PRODUCT PROMPT '찾으려는 상품명의 일부를 입력해주세요';
DECLARE
    V_PRODUCT VARCHAR(30) := '&K_PRODUCT';
    CURSOR S2
    IS
    SELECT * FROM SHOP WHERE SANGPUM LIKE '%'||V_PRODUCT||'%';
    
    V_COUNT NUMBER(3);
BEGIN
    SELECT COUNT(*) INTO V_COUNT FROM SHOP WHERE SANGPUM LIKE '%'||V_PRODUCT||'%';
    IF V_COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE(V_PRODUCT||'과 관련된 상품이 없습니다');
    ELSE
        DBMS_OUTPUT.PUT_LINE(V_COUNT||'개가 있습니다');
        FOR S IN S2 LOOP
            DBMS_OUTPUT.PUT_LINE('상품명: '||S.SANGPUM);
            DBMS_OUTPUT.PUT_LINE('색 상: '||S.COLOR);
            DBMS_OUTPUT.PUT_LINE('단 가: '||S.DAN);
            DBMS_OUTPUT.PUT_LINE('-------------');
        END LOOP;
    END IF; 
END;
/

/*
CREATE [OR REPLACE] 



*/

-- 새로운 프로시져 생성
CREATE OR REPLACE PROCEDURE MYTEST
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('첫 프로시져 생성!!');
END;
/

-- MYTEST 프로시져 호출
EXEC MYTEST;

-- 구구단을 출력하는 프로시저 생성
CREATE OR REPLACE PROCEDURE GUGU(DAN NUMBER)
IS
BEGIN
    IF DAN < 2 OR DAN > 9 THEN
        DBMS_OUTPUT.PUT_LINE('범위 벗어남');
    ELSE
        DBMS_OUTPUT.PUT_LINE(' ** '||DAN||' ** ');
        DBMS_OUTPUT.PUT_LINE('  ');
        FOR A IN 1..9 LOOP
            DBMS_OUTPUT.PUT_LINE(DAN||' X '||A||' = '||DAN * A);
        END LOOP;
    END IF;
END;
/

-- GUGU 실행
EXEC GUGU(5);

-- shop에 상품을 추가하는 프로시저
CREATE OR REPLACE PROCEDURE ADDSHOP (
    SANGPUM SHOP.SANGPUM%TYPE, SU SHOP.SU%TYPE,
    DAN SHOP.DAN%TYPE, COLOR SHOP.COLOR%TYPE
)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('SHOP DB 에 '||SANGPUM||' 데이터를 추가합니다');
    INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL, SANGPUM, SU, DAN, SYSDATE, COLOR);
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT||'개의 상품이 추가되었습니다');
END;
/

-- 상품추가
EXEC ADDSHOP('모바지', 1, 200000, 'WHITE');

/*
    EXEC SERCHSANGPUM('면바지');
    
    상품명 색상 단가
*/
--ACCEPT K_PS PROMPT '검색할 단어 입력';
CREATE OR REPLACE PROCEDURE SERCHSANGPUM (
    V_SANG SHOP.SANGPUM%TYPE
)
IS
    CURSOR S3
    IS
    SELECT * FROM SHOP WHERE SANGPUM LIKE '%'||V_SANG||'%';
    V_COUNT NUMBER(3);
BEGIN
    SELECT COUNT(*) INTO V_COUNT
    FROM SHOP WHERE SANGPUM LIKE '%'||V_SANG||'%';
    
    IF V_COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE(V_SANG||' 관련 상품은 없습니다');
    ELSE
        FOR S IN S3 LOOP
            DBMS_OUTPUT.PUT_LINE('상품명: '||S.SANGPUM);
            DBMS_OUTPUT.PUT_LINE('색 상: '||S.COLOR);
            DBMS_OUTPUT.PUT_LINE('단 가: '||S.DAN);
            DBMS_OUTPUT.PUT_LINE('-------------');
        END LOOP;
    END IF;
END;
/

EXEC SERCHSANGPUM('바지');