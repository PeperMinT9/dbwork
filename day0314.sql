-- emp ���̺� ��ü �÷� ��ȸ
select * from emp;
-- emp ���̺� �ִ� ������ ������ ���(���� ������ �ѹ���)
SELECT DISTINCT job from emp;
-- �÷��� ��Ī�� ����
select ename as "�����", job as "����" from emp;
-- ��Ī�� �����߰��� ������ ������ " ��������
select ename "���� �����", job ���� from emp;
-- ����: empno�� 7369, 7566 �ΰ��� ������ Ȯ��
select * from emp where empno = 7369 or empno = 7566;
-- SMITH, WARD �� ������ ���
SELECT * FROM EMP WHERE ENAME='SMITH' OR ENAME='WARD';
-- IN ������
SELECT * FROM EMP WHERE ename IN ('SMITH','WARD','SCOTT','FORD');
SELECT * FROM EMP WHERE EMPNO IN ('7369', '7654', '7788', '7876');
-- AND �������� ��ȸ�ϴ� ���
SELECT ENAME, JOB, SAL, COMM FROM EMP WHERE SAL >= 1500 AND SAL <= 3000;
-- ���� SQL ���� BETWEEN ���ε� ��ȸ�� ����
SELECT ENAME, JOB, SAL, COMM FROM EMP WHERE SAL  BETWEEN 1500 AND 3000;
-- �۾��� MANAGER�� ����� SAL�� 2õ �̻��λ��
SELECT * FROM EMP WHERE JOB = 'MANAGER' AND SAL >= 2000;
-- COMM�� NULL�� ��츸 ���
SELECT * FROM EMP WHERE COMM IS NULL;
-- NULL�� �ƴѰ��
SELECT * FROM EMP WHERE COMM IS NOT NULL;
-- ENAME�� A�� �����ϴ� ������ ��ȸ
SELECT * FROM EMP WHERE ENAME LIKE 'A%';
-- ENAMEDL S�� ������ ��� ������ ��ȸ
SELECT * FROM EMP WHERE ENAME LIKE '%S';
-- ENAME�� A�� S�� �����ϴ� ������ ��ȸ
SELECT * FROM EMP WHERE ENAME LIKE 'A%' OR ENAME LIKE 'S%';
-- ENAME�� 2��°�� 3��° ���ڰ� A�λ�� ��ȸ
SELECT * FROM EMP WHERE ENAME LIKE '_A%' OR ENAME LIKE '__A%';
-- JOB�� MANAGER�� ANALYST�߿� SAL�� 2500�̻��� ����� ��ȸ
SELECT * FROM EMP WHERE (JOB = 'MANAGER' OR JOB = 'ANALYST') AND SAL >= 2500;
-- IN���� ����
SELECT * FROM EMP WHERE JOB IN ('MANAGER', 'ANALYST') AND SAL >= 2500;
-- SCOTT�� ������ ���� ������ �޴� ����� ��ȸ
SELECT * FROM EMP WHERE SAL = (SELECT SAL FROM EMP WHERE ENAME = 'SCOTT');
-- ALLEN�� ������ ���� ������ ���� ����� ��ȸ�ϱ�
SELECT * FROM EMP WHERE JOB = (SELECT JOB FROM EMP WHERE ENAME = 'ALLEN');
-- CONSOLE�� ��½� TABLE���� DUAL, PPT 48������ �����Լ�
SELECT ABS(-6), ABS(6) FROM DUAL;
SELECT CEIL(2.35), CEIL(2.11) FROM DUAL; -- ������ �ø� �Ҽ��� ����
SELECT FLOOR(2.9), FLOOR(2.11) FROM DUAL; -- ������ ����
SELECT ROUND(2.356, 1), ROUND(2.22,1) FROM DUAL; -- �Ҽ��� ������ �ڸ� �������� �ݿø�
SELECT TRUNC(2.356, 1), TRUNC(2.22, 1) FROM DUAL; -- ������ �ڸ� �� ������ �ݳ���
SELECT ROUND(234567, -1), ROUND(234567,-2) FROM DUAL; -- 234570, 234600
SELECT POWER(2, 3), POWER(3, 4) FROM DUAL; -- �����±��ϱ� 8, 81
SELECT MOD(7, 2), MOD(10, 2) FROM DUAL; -- ������

-- 49������ ���ڿ� �Լ�
SELECT CONCAT('JAVA', 'SPING') FROM DUAL; -- ���ڿ� ��ġ��
-- ���ڿ� ��ġ���� ��� || �ε� �����ϴ�
SELECT 'JAVA'||'SPING' FROM DUAL;
-- TABLE EMP�� �غ���
SELECT ENAME||'���� �̸��� '||JOB||'�Դϴ�' MESSAGE FROM EMP; -- MESSAGE�� �÷���
SELECT ENAME||'���� ������ '||SAL||'$ �Դϴ�' FROM EMP;
SELECT INITCAP(ENAME) FROM EMP; -- ù���ڸ� �빮�ڷ� ���
SELECT UPPER(ENAME), LOWER(ENAME) FROM EMP; -- �빮��, �ҹ��ڷ� ��ȯ�� ���
-- LPAD, RAPD: Ư�� ���ڷ� ä���
SELECT LPAD('HAPPY', 10, '*') FROM DUAL; -- �����ڸ��� ���°� ��ŭ *�� ä����
SELECT RPAD('HAPPY', 10, '*') FROM DUAL; -- ������ �ڸ��� ä����
SELECT ENAME, LPAD(SAL, 10, '*') FROM EMP;
-- SUBSTR ���ڿ� ���� ORACLE DB�� ù���ڴ� 0�� �ƴ϶� 1
SELECT SUBSTR('HAPPY DAY', 3, 3),SUBSTR('HAPPY DAY', -3, 3) FROM DUAL;
SELECT RPAD(SUBSTR(ename, 1, 2), 3, '*') FROM EMP;
-- INSTR: Ư�� ���ڿ� ��ġ ���ϱ�
SELECT INSTR('GOOD DAY', 'DAY') FROM DUAL; -- 6
SELECT INSTR('GOOD DAY', 'HAPPY') FROM DUAL; -- 0 ������� 0
-- TRIM
SELECT '*'||TRIM('   HELLO   ')||'*' FROM DUAL; -- ��������
SELECT '*'||LTRIM('   HELLO   ')||'*' FROM DUAL; -- ������������
SELECT '*'||RTRIM('   HELLO   ')||'*' FROM DUAL; -- ������������
-- SYSDATR: ���� ��¥���ϱ�
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE+1 FROM DUAL; -- ���� ��¥ 

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') TODAY FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD AM HH:MI:SS') TODAY FROM DUAL; -- 2023-03-14 ���� 03:24:04
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') TODAY FROM DUAL; -- 2023-03-14 15:24:21
SELECT TO_CHAR(23456789, 'L999,999,999') FROM DUAL; -- ����(�ѱ������� ��ȭ)ȭ�� ǥ�� ��23,456,789
SELECT TO_CHAR(23456789, 'L000,000,000') FROM DUAL; --         ��023,456,789
SELECT TO_CHAR(23456789, '$999,999,999') FROM DUAL; -- �޷��� ǥ��
SELECT TO_CHAR(2.3, '0.00') FROM DUAL; -- 2.30 

-- NVL: NULL���� ��� Ư���� ���(MYSQL������ IFNULL)
SELECT NVL(MGR, 1000), NVL(COMM, 0) FROM EMP;
SELECT SAL + COMM FROM EMP; -- COMM�� NULL�� ��� ���ϸ� ����� NULL
-- COMM�� NULL�� ��� 10���� ���
SELECT SAL + NVL(COMM, 10) FROM EMP;
-- DECODE: ���� ���� ���� �ٸ� �� ���
SELECT ENAME, DEPTNO, DECODE(DEPTNO, 10, '����', 20, '������', 30, '��⵵', 40, '���ֵ�') CITY FROM EMP;
-- ORDER ������� ���
SELECT ENAME, SAL FROM EMP ORDER BY ENAME ASC; -- ENAME�� ��������(ASC ��������)
SELECT ENAME, SAL FROM EMP ORDER BY SAL DESC; -- SAL�� ��������
-- ������ ���, ���� �����ϰ�� ������ ��������
SELECT ENAME, JOB, SAL FROM EMP ORDER BY JOB, SAL DESC;
-- SAL�� �������� ��½� SAL�� 3��° ����ϹǷ� ����ȣ 3���� ����
SELECT ENAME, JOB, SAL FROM EMP ORDER BY 3;
-- ���� 1500-3000������ ����ϴµ� �̸��� ��������
SELECT * FROM EMP WHERE SAL BETWEEN 1500 AND 3000 ORDER BY ENAME;

-- �׷��Լ�: PTT 57
-- count, max, min, sum, avg
select count(*) from emp; -- emp�� ������ ����
select max(sal) from emp; -- �ֱױ޿�
select min(sal) from emp;
select sum(sal) from emp; -- �޿��� �հ�
select avg(sal) from emp;
select round(avg(sal), -1) from emp; -- �޿��� ���, �Ͽ��������� �ݿø�

-- group�� �Լ� ����
-- �� ������ �ο����� sal�� ����� ���غ���
select job as ����, count(*) as �ο���, avg(sal) as ��տ��� from emp group by job;

-- ���� ���������� �ο����� �����ź��� ���
select job as ����, count(*) as �ο���, avg(sal) as ��տ��� from emp group by job order by �ο���;

-- ���� ���������� ������ �ο����� 3�� �̻��� �����͸� ���
select job ����, count(*) �ο���, round(avg(sal), -1) as ��տ��� from emp group by job having count(*) >= 3 order by �ο���;

-- �� �������� �ο����� �ְ���, ���������� ���(�ְ����� ��������)
select job, count(*), max(sal), min(sal) from emp group by job order by job; -- order by�� �÷���ȣ ��밡�� ���⼭�� 1

-- ���� �������� �ݾ׾տ� ȭ������� ���̰� 3�ڸ� �ĸ� �߰��Ϸ���
select job, count(*), to_char(max(sal), 'L999,999'), to_char(min(sal), 'L999,999') from emp group by job order by job;

--1. emp���̺��� ename a�� s�� �����ϴ»�� ���(��ҹ��� �������)
SELECT * FROM EMP WHERE LOWER(ENAME) LIKE 'a%' OR LOWER(ENAME) LIKE 's%';
--2. emp���̺��� ename ���� �ι�° ���ڰ� 'A' �λ�� ���
SELECT * FROM EMP WHERE ENAME LIKE '_A%';
--3. job ���� ���� �������ϰ�� �ѹ����� ����Ͻÿ�
SELECT DISTINCT JOB FROM EMP;
--4. job �������� �ο����� ���Ͻÿ�
SELECT JOB, COUNT(*) FROM EMP GROUP BY JOB;
--5. job �������� sal �� ��ձ޿��� ���Ͻÿ�
SELECT JOB, AVG(SAL) FROM EMP GROUP BY JOB;
--6. job �������� sal �� �ִ밪�� �ּҰ��� ���Ͻÿ�
SELECT JOB, MAX(SAL), MIN(SAL) FROM EMP GROUP BY JOB;
--7. deptno �� 10�ΰ�� 'ȫ����'
--   20 �ΰ�� '���ߺ�' 30�ΰ�� '������' �μ��� ���Ͽ�
--   ename, �μ� �� ����Ͻÿ�
SELECT ENAME, DECODE(DEPTNO, 10, 'ȫ����', 20, '���ߺ�', 30, '������') AS �μ� FROM EMP;
--8. �޿�(sal)�� sal �� ��պ��� �� ���� ����� ename �� sal �� ����Ͻÿ�
SELECT ENAME, SAL FROM EMP WHERE SAL >= (SELECT AVG(SAL) FROM EMP);
--9. hiredate ���� ���� 5���� ����� ename �� hiredate �� ����Ͻÿ�
SELECT ENAME, HIREDATE FROM EMP WHERE TO_CHAR(HIREDATE, 'MM') = '05';
SELECT ENAME, HIREDATE FROM EMP WHERE TO_CHAR(HIREDATE, 'MM') = 5;
--10. SCOTT �� �޿��� �����ϰų� �� ���� �޴� ������ �޿��� ����϶�
SELECT ENAME, SAL FROM EMP WHERE SAL >= (SELECT SAL FROM EMP WHERE ENAME='SCOTT');

