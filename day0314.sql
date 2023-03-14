-- emp 테이블 전체 컬럼 조회
select * from emp;
-- emp 테이블에 있는 직업의 종류를 출력(같은 직업은 한번만)
SELECT DISTINCT job from emp;
-- 컬럼명에 별칭을 지정
select ename as "사원명", job as "직업" from emp;
-- 별칭은 제목중간에 공백이 없을시 " 생략가능
select ename "은행 사원명", job 직업 from emp;
-- 조건: empno가 7369, 7566 두개의 데이터 확인
select * from emp where empno = 7369 or empno = 7566;
-- SMITH, WARD 의 데이터 출력
SELECT * FROM EMP WHERE ENAME='SMITH' OR ENAME='WARD';
-- IN 연산자
SELECT * FROM EMP WHERE ename IN ('SMITH','WARD','SCOTT','FORD');
SELECT * FROM EMP WHERE EMPNO IN ('7369', '7654', '7788', '7876');
-- AND 연산으로 조회하는 경우
SELECT ENAME, JOB, SAL, COMM FROM EMP WHERE SAL >= 1500 AND SAL <= 3000;
-- 위의 SQL 문을 BETWEEN 으로도 조회가 가능
SELECT ENAME, JOB, SAL, COMM FROM EMP WHERE SAL  BETWEEN 1500 AND 3000;
-- 작업이 MANAGER인 사람중 SAL이 2천 이상인사람
SELECT * FROM EMP WHERE JOB = 'MANAGER' AND SAL >= 2000;
-- COMM이 NULL인 경우만 출력
SELECT * FROM EMP WHERE COMM IS NULL;
-- NULL이 아닌경우
SELECT * FROM EMP WHERE COMM IS NOT NULL;
-- ENAME이 A로 시작하는 데이터 조회
SELECT * FROM EMP WHERE ENAME LIKE 'A%';
-- ENAMEDL S로 끝나느 모든 데이터 조회
SELECT * FROM EMP WHERE ENAME LIKE '%S';
-- ENAME이 A나 S로 시작하는 데이터 조회
SELECT * FROM EMP WHERE ENAME LIKE 'A%' OR ENAME LIKE 'S%';
-- ENAME의 2번째나 3번째 글자가 A인사람 조회
SELECT * FROM EMP WHERE ENAME LIKE '_A%' OR ENAME LIKE '__A%';
-- JOB이 MANAGER나 ANALYST중에 SAL이 2500이상인 사람만 조회
SELECT * FROM EMP WHERE (JOB = 'MANAGER' OR JOB = 'ANALYST') AND SAL >= 2500;
-- IN으루 수정
SELECT * FROM EMP WHERE JOB IN ('MANAGER', 'ANALYST') AND SAL >= 2500;
-- SCOTT의 연봉과 같은 연봉을 받는 사람을 조회
SELECT * FROM EMP WHERE SAL = (SELECT SAL FROM EMP WHERE ENAME = 'SCOTT');
-- ALLEN의 직업과 같은 직업을 가진 사람들 조회하기
SELECT * FROM EMP WHERE JOB = (SELECT JOB FROM EMP WHERE ENAME = 'ALLEN');
-- CONSOLE에 출력시 TABLE명을 DUAL, PPT 48페이지 내장함수
SELECT ABS(-6), ABS(6) FROM DUAL;
SELECT CEIL(2.35), CEIL(2.11) FROM DUAL; -- 무조건 올림 소수점 이하
SELECT FLOOR(2.9), FLOOR(2.11) FROM DUAL; -- 무조건 내림
SELECT ROUND(2.356, 1), ROUND(2.22,1) FROM DUAL; -- 소수점 지정한 자리 값전까지 반올림
SELECT TRUNC(2.356, 1), TRUNC(2.22, 1) FROM DUAL; -- 지정한 자리 값 전까지 반내림
SELECT ROUND(234567, -1), ROUND(234567,-2) FROM DUAL; -- 234570, 234600
SELECT POWER(2, 3), POWER(3, 4) FROM DUAL; -- 지수승구하기 8, 81
SELECT MOD(7, 2), MOD(10, 2) FROM DUAL; -- 나머지

-- 49페이지 문자열 함수
SELECT CONCAT('JAVA', 'SPING') FROM DUAL; -- 문자열 합치기
-- 문자열 합치기의 경우 || 로도 가능하다
SELECT 'JAVA'||'SPING' FROM DUAL;
-- TABLE EMP로 해보기
SELECT ENAME||'님의 이름은 '||JOB||'입니다' MESSAGE FROM EMP; -- MESSAGE는 컬럼명
SELECT ENAME||'님의 연봉은 '||SAL||'$ 입니다' FROM EMP;
SELECT INITCAP(ENAME) FROM EMP; -- 첫글자만 대문자로 출력
SELECT UPPER(ENAME), LOWER(ENAME) FROM EMP; -- 대문자, 소문자로 변환후 출력
-- LPAD, RAPD: 특정 문자로 채우기
SELECT LPAD('HAPPY', 10, '*') FROM DUAL; -- 왼쪽자리를 남는것 만큼 *로 채워라
SELECT RPAD('HAPPY', 10, '*') FROM DUAL; -- 오른쪽 자리를 채워라
SELECT ENAME, LPAD(SAL, 10, '*') FROM EMP;
-- SUBSTR 문자열 추출 ORACLE DB는 첫글자는 0이 아니라 1
SELECT SUBSTR('HAPPY DAY', 3, 3),SUBSTR('HAPPY DAY', -3, 3) FROM DUAL;
SELECT RPAD(SUBSTR(ename, 1, 2), 3, '*') FROM EMP;
-- INSTR: 특정 문자열 위치 구하기
SELECT INSTR('GOOD DAY', 'DAY') FROM DUAL; -- 6
SELECT INSTR('GOOD DAY', 'HAPPY') FROM DUAL; -- 0 없을경우 0
-- TRIM
SELECT '*'||TRIM('   HELLO   ')||'*' FROM DUAL; -- 공백제거
SELECT '*'||LTRIM('   HELLO   ')||'*' FROM DUAL; -- 좌측공백제거
SELECT '*'||RTRIM('   HELLO   ')||'*' FROM DUAL; -- 우측공백제거
-- SYSDATR: 현재 날짜구하기
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE+1 FROM DUAL; -- 내일 날짜 

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') TODAY FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD AM HH:MI:SS') TODAY FROM DUAL; -- 2023-03-14 오후 03:24:04
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') TODAY FROM DUAL; -- 2023-03-14 15:24:21
SELECT TO_CHAR(23456789, 'L999,999,999') FROM DUAL; -- 지역(한국에서는 원화)화폐 표시 ￦23,456,789
SELECT TO_CHAR(23456789, 'L000,000,000') FROM DUAL; --         ￦023,456,789
SELECT TO_CHAR(23456789, '$999,999,999') FROM DUAL; -- 달러로 표시
SELECT TO_CHAR(2.3, '0.00') FROM DUAL; -- 2.30 

-- NVL: NULL값일 경우 특정값 출력(MYSQL에서는 IFNULL)
SELECT NVL(MGR, 1000), NVL(COMM, 0) FROM EMP;
SELECT SAL + COMM FROM EMP; -- COMM이 NULL일 경우 더하면 결과도 NULL
-- COMM이 NULL일 경우 10으로 계산
SELECT SAL + NVL(COMM, 10) FROM EMP;
-- DECODE: 값에 따라 서로 다른 값 출력
SELECT ENAME, DEPTNO, DECODE(DEPTNO, 10, '서울', 20, '강원도', 30, '경기도', 40, '제주도') CITY FROM EMP;
-- ORDER 순서대로 출력
SELECT ENAME, SAL FROM EMP ORDER BY ENAME ASC; -- ENAME의 오름차순(ASC 생략가능)
SELECT ENAME, SAL FROM EMP ORDER BY SAL DESC; -- SAL의 내림차순
-- 직업순 출력, 같은 직업일경우 연봉의 내림차순
SELECT ENAME, JOB, SAL FROM EMP ORDER BY JOB, SAL DESC;
-- SAL의 오름차순 출력시 SAL이 3번째 출력하므로 열번호 3으로 정렬
SELECT ENAME, JOB, SAL FROM EMP ORDER BY 3;
-- 연봉 1500-3000까지만 출력하는데 이름의 오름차순
SELECT * FROM EMP WHERE SAL BETWEEN 1500 AND 3000 ORDER BY ENAME;

-- 그룹함수: PTT 57
-- count, max, min, sum, avg
select count(*) from emp; -- emp의 데이터 갯수
select max(sal) from emp; -- 최그급여
select min(sal) from emp;
select sum(sal) from emp; -- 급여의 합계
select avg(sal) from emp;
select round(avg(sal), -1) from emp; -- 급여의 평균, 일원단위에서 반올림

-- group별 함수 적용
-- 각 직업별 인원수와 sal의 평균을 구해보자
select job as 직업, count(*) as 인원수, avg(sal) as 평균연봉 from emp group by job;

-- 위의 쿼리문에서 인원수가 작은거부터 출력
select job as 직업, count(*) as 인원수, avg(sal) as 평균연봉 from emp group by job order by 인원수;

-- 위의 쿼리문에서 직업별 인원수가 3명 이상인 데이터만 출력
select job 직업, count(*) 인원수, round(avg(sal), -1) as 평균연봉 from emp group by job having count(*) >= 3 order by 인원수;

-- 각 직업별로 인원수와 최고연봉, 최저연봉을 출력(최고연봉의 내림차순)
select job, count(*), max(sal), min(sal) from emp group by job order by job; -- order by에 컬럼번호 사용가능 여기서는 1

-- 위의 쿼리문에 금액앞에 화폐단위를 붙이고 3자리 컴마 추가하려면
select job, count(*), to_char(max(sal), 'L999,999'), to_char(min(sal), 'L999,999') from emp group by job order by job;

--1. emp테이블에서 ename a나 s로 시작하는사람 출력(대소문자 상관없음)
SELECT * FROM EMP WHERE LOWER(ENAME) LIKE 'a%' OR LOWER(ENAME) LIKE 's%';
--2. emp테이블에서 ename 에서 두번째 글자가 'A' 인사람 출력
SELECT * FROM EMP WHERE ENAME LIKE '_A%';
--3. job 에서 같은 직업군일경우 한번씩만 출력하시오
SELECT DISTINCT JOB FROM EMP;
--4. job 종류별로 인원수를 구하시오
SELECT JOB, COUNT(*) FROM EMP GROUP BY JOB;
--5. job 종류별로 sal 의 평균급여를 구하시오
SELECT JOB, AVG(SAL) FROM EMP GROUP BY JOB;
--6. job 종류별로 sal 의 최대값과 최소값을 구하시오
SELECT JOB, MAX(SAL), MIN(SAL) FROM EMP GROUP BY JOB;
--7. deptno 가 10인경우 '홍보부'
--   20 인경우 '개발부' 30인경우 '관리부' 부서를 구하여
--   ename, 부서 를 출력하시오
SELECT ENAME, DECODE(DEPTNO, 10, '홍보부', 20, '개발부', 30, '관리부') AS 부서 FROM EMP;
--8. 급여(sal)가 sal 의 평균보다 더 높은 사람만 ename 과 sal 을 출력하시오
SELECT ENAME, SAL FROM EMP WHERE SAL >= (SELECT AVG(SAL) FROM EMP);
--9. hiredate 에서 월이 5월인 사람만 ename 과 hiredate 를 출력하시오
SELECT ENAME, HIREDATE FROM EMP WHERE TO_CHAR(HIREDATE, 'MM') = '05';
SELECT ENAME, HIREDATE FROM EMP WHERE TO_CHAR(HIREDATE, 'MM') = 5;
--10. SCOTT 의 급여와 동일하거나 더 많이 받는 사원명과 급여를 출력하라
SELECT ENAME, SAL FROM EMP WHERE SAL >= (SELECT SAL FROM EMP WHERE ENAME='SCOTT');

