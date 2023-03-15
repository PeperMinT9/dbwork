-- ppt 23������ table
-- table ���� (person): ��ȣ, �̸�, ����, ����, ����, ���糯¥
CREATE TABLE PERSON (
    NUM NUMBER(3) PRIMARY KEY,
    NAME VARCHAR2(15) NOT NULL,
    AGE NUMBER(3),
    GENDER VARCHAR2(10) DEFAULT '����',
    CITY VARCHAR2(15) DEFAULT '����',
    TODAY DATE
);

-- ������ ��ȸ
SELECT * FROM PERSON;

-- INSERT �÷������� �Ϻθ� �߰��� ���
INSERT INTO PERSON (NUM, NAME, TODAY) VALUES (1, '�ƹ���', SYSDATE);

-- PK(PRIMARY KEY), NN(NOT NULL) �� ��� ���� �ȳ־��ָ� �����߻�-Ȯ��
INSERT INTO PERSON (NAME, AGE, TODAY) VALUES ('�̹���', 23, '2022-10-10'); -- ����
-- NN �Ӽ��� �� �÷��� ������ �־�����Ѵ�, �̹����� NUM�� ���� �����͸� �־��
INSERT INTO PERSON (NUM, NAME, AGE, TODAY) VALUES (1, '�̹���', 23, '2022-10-10'); -- ���Ἲ ���� ���� ����
-- �������� �������� ����� �־��
INSERT INTO PERSON (NUM, NAME, AGE, TODAY) VALUES (2, '�̹���', 23, '2022-10-10');
-- �Ϻ� �÷��� �ƴ϶� ������� ��� �÷����� ������� �÷��� ���� ����
INSERT INTO PERSON VALUES (3, '�ڹ���', 34, '����', '���ֵ�', '2021-12-21');
-- ���� 7�� ���� �߰��غ���
INSERT INTO PERSON VALUES (4, '�蹫��', 15, '����', '�λ�', '2023-05-19');
INSERT INTO PERSON VALUES (5, '������', 43, '����', '����', '2021-05-31');
INSERT INTO PERSON VALUES (6, '�ܹ���', 24, '����', '��õ', '2016-06-27');
INSERT INTO PERSON VALUES (7, '������', 34, '����', '��õ', '2018-08-22');
INSERT INTO PERSON VALUES (8, '�ǹ���', 64, '����', '����', '2014-11-08');
INSERT INTO PERSON VALUES (9, '������', 18, '����', '����', '2011-10-04');
INSERT INTO PERSON VALUES (10, '�ȹ���', 22, '����', '��õ', '2009-04-30');
COMMIT;
-- �������� AGE, CITY ����
UPDATE PERSON SET AGE=26, CITY='���ֵ�' WHERE NAME = '������';
-- ȫ�浿�� ���� ����
UPDATE PERSON SET AGE=42 WHERE NAME = 'ȫ�浿';
-- �������� TODAY�� ���� ��¥�� ����
UPDATE PERSON SET TODAY = SYSDATE WHERE NAME = '������';
COMMIT;
-- DELETE: WHERE ������ ��ü ��� ������
DELETE FROM PERSON;
-- �ٽ� �츮��
ROLLBACK;
-- ������ �̿��ؼ� ����
DELETE FROM PERSON WHERE NAME = 'ȫ�浿';
-- ���̰� 30�� �̸��� ��� ����
DELETE FROM PERSON WHERE AGE < 30;
ROLLBACK;

-- ���ݺ��ʹ� ���̺� ������ �����ϴ� ����
-- ���̺� �÷� �߰�
ALTER TABLE PERSON ADD SCORE NUMBER(3) DEFAULT 50;

-- ��� �߰��� SCORE �÷��� ����
ALTER TABLE PERSON DROP COLUMN SCORE;

-- �÷� Ÿ�� ����
ALTER TABLE PERSON MODIFY CITY VARCHAR2(20);

-- �÷��� ���� TODAY -> IPSADAY �� ����
ALTER TABLE PERSON RENAME COLUMN TODAY TO IPSADAY;

-- ���� ������ ����: NAME�� NOT NULL ���������� ����ִ�(���������̸��� ���༭ �⺻ �̸����� ���ִ�)
-- SYS_C008320 ����
ALTER TABLE PERSON DROP CONSTRAINT SYS_C008320;

-- PPT 30������
-- NAME�� ���ο� ���������� �߰��غ���(UNIQUE)
ALTER TABLE PERSON ADD CONSTRAINT PERSON_UQ_NAME UNIQUE(NAME);

-- �̸��� ���� �̸��� ������ ���� ������ �߻�
-- ORA-00001: ���Ἲ ���� ����(ANGEL.PERSON_UQ_NAME)�� ����˴ϴ�
INSERT INTO PERSON (NUM, NAME) VALUES (11, '�ڹ���');

-- GENDER�� '����', '����' ���� �����͸� ������ ������ �߻��ϵ��� CHECK ���������� �߰��غ���
ALTER TABLE PERSON ADD CONSTRAINT PERSON_CK_GENDER CHECK (GENDER IN ('����', '����'));

-- AGE �� 10-50���� �߰� �����ϵ��� ���� ������ �߰�
ALTER TABLE PERSON ADD CONSTRAINT PERSON_CK_AGE CHECK (AGE >= 10 AND AGE <= 70);

-- ����1
-- PK ���������� ������ PERSON_PK_NUM �̶�� ���ο� ���������� �߰��غ���
ALTER TABLE PERSON DROP CONSTRAINT SYS_C008321;
ALTER TABLE PERSON ADD CONSTRAINT PERSON_PK_NUM PRIMARY KEY(NUM);

-- ����2
-- BUSEO��� �÷��� �߰� VARCHAR2(10)�� �⺻���� '������'
ALTER TABLE PERSON ADD BUSEO VARCHAR2(10) DEFAULT '������';
-- BUSEO�� �������� �߰� '������', 'ȫ����', '�λ��' 3���� �߰� �����ϵ���
ALTER TABLE PERSON ADD CONSTRAINT PERSON_CK_BUSEO CHECK (BUSEO IN ('������', 'ȫ����', '�λ��'));

-- ����3
-- �ھ�, �̾� ���� ���� ������� ��� '�λ��'�� ����
UPDATE PERSON SET BUSEO = '�λ��' WHERE NAME LIKE '��%' OR NAME LIKE '��%';
-- �达, ���� ���� ���� ������� ��� 'ȫ����'�� ����
UPDATE PERSON SET BUSEO = 'ȫ����' WHERE NAME LIKE '��%' OR NAME LIKE '��%';

-- ����4
-- ���� ���� ������ �ο����� ��ճ���(����Ÿ��) ���ϱ�
SELECT GENDER, COUNT(*), AVG(AGE) FROM PERSON GROUP BY GENDER ORDER BY 2 DESC;
-- �μ����� �ο����� ��ճ��� ���ϱ�
SELECT BUSEO, COUNT(*), ROUND(AVG(AGE), 0) FROM PERSON GROUP BY BUSEO ORDER BY BUSEO;

-- ������ �����ϴ� ��� PPT 78������
-- ���� ���� ����ϴ� �⺻ ������: 1���� 1�� �����ϴ� ������
CREATE SEQUENCE SEQ1;
CREATE SEQUENCE SEQ2 START WITH 1 INCREMENT BY 1; -- ���� ����
CREATE SEQUENCE SEQ3 START WITH 10 INCREMENT BY 5 NOCACHE; -- NOCACHE: CACHE�� 0����
CREATE SEQUENCE SEQ4 MAXVALUE 100; -- MAX���� 100������ �߻��ȴ�.

-- ������ ��ȸ
SELECT * FROM SEQ;
 -- ���̺� ��ȸ
SELECT * FROM TAB;

-- ������ ����
DROP SEQUENCE SEQ2;
DROP SEQUENCE SEQ4;

-- ���� �� �߻� NEXTVAL, ���簪 CURRVAL
SELECT SEQ1.NEXTVAL, SEQ3.NEXTVAL FROM DUAL; -- �ݺ��ؼ� ����
SELECT SEQ1.NEXTVAL, SEQ3.CURRVAL FROM DUAL; -- ������ �߻��� ��