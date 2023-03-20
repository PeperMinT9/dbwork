-- PLSQL ������ ���̺��� ������ ������ ����
CREATE SEQUENCE SEQ_TEST NOCACHE; -- 1���� �����ϴ� ������
CREATE TABLE SHOP (
    NUM NUMBER(3) CONSTRAINT SHOP_PK_NUM PRIMARY KEY,
    SANGPUM VARCHAR2(30),
    SU NUMBER(3),
    DAN NUMBER(7),
    TODAY DATE
);

--DROP SEQUENCE SEQ_TEST;
--DROP TABLE SHOP;

-- �⺻ ������ 5��
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL, 'û����', 2, 19000, SYSDATE);
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL, '�����', 1, 21000, SYSDATE);
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL, '�ع���', 1, 23000, SYSDATE);
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL, '�����', 3, 27000, SYSDATE);
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL, '�����', 2, 32000, SYSDATE);
COMMIT;



-- PL-SQL: SQL �� ������ ��Ҹ� �߰��ؼ� ���α׷����Ѱ��� PL SQL �̶�� �Ѵ�
-- ����
-- DECLARE
-- ��������, Ŀ������
-- BEGIN
-- ���� ��� �Ǵ� ������
-- DBMS_OUT.PUT_PUT_LINE(); ������� ���ɾ�
-- END;

-- SET SERVEROUTPUT ON �ܼ�â�� ����� �������ϱ�
-- SET SERVEROUTPUT OFF �ܼ�â�� ����� �ȳ�����
SET SERVEROUTPUT OFF

DECLARE
    V_NO NUMBER(4, 1); -- 4�ڸ� ����, �Ҽ������� 1�ڸ�
BEGIN
    V_NO := 10;
    DBMS_OUTPUT.PUT_LINE('���ڴ�'||V_NO||'�Դϴ�'); 
END;
 
-- SHOP ���̺����� Ư�� ��ǰ���� ������
DECLARE
    V_SNAGPUM VARCHAR2(30);
    V_SANGPUM VARCHAR2(30);
    V_SU NUMBER(3);
    V_DAN NUMBER(7);
    V_NUM NUMBER(3) := 3; -- �˻��ؼ� ������ NUM��
BEGIN
    SELECT SANGPUM, SU, DAN 
    INTO V_SANGPUM, V_SU, V_DAN
    FROM SHOP WHERE NUM = V_NUM;
    DBMS_OUTPUT.PUT_LINE(V_NUM||'�� ��ǰ����');
    DBMS_OUTPUT.PUT_LINE('��ǰ��: '||V_SANGPUM);
    DBMS_OUTPUT.PUT_LINE('�� ��: '||V_SU);
    DBMS_OUTPUT.PUT_LINE('�� ��: '||V_DAN);
    DBMS_OUTPUT.PUT_LINE('�ѱݾ�: '||V_SU * V_DAN);
END;
/

-- SHOP ���̺����� Ư�� ��ǰ���� ������
DECLARE
    V_SANGPUM VARCHAR2(30) := 'û����'; -- �˻��ؼ� ������ SANGPUM��
    V_SU NUMBER(3);
    V_DAN NUMBER(7);
    V_NUM NUMBER(3); 
BEGIN
    SELECT NUM, SU, DAN
    INTO V_NUM, V_SU, V_DAN
    FROM SHOP WHERE SANGPUM = V_SANGPUM;
    DBMS_OUTPUT.PUT_LINE(V_SANGPUM||'��ǰ����');
    DBMS_OUTPUT.PUT_LINE('��������: '||V_NUM);
    DBMS_OUTPUT.PUT_LINE('�� ��: '||V_SU);
    DBMS_OUTPUT.PUT_LINE('�� ��: '||V_DAN);
    DBMS_OUTPUT.PUT_LINE('�ѱݾ�: '||V_SU * V_DAN);
END;
/

-- ���ǹ�
/*
���� ���ǹ�
    IF ���ǽ� THEN
        ����1;
    ELSE
        ����2;
    END IF;
    
�������ǹ�
    IF ���ǽ�1 THEN
        ����1;
    ELSIF ���ǽ�2 THEN
        ����2;
    .......
    END IF;
*/

-- Ư���⵵�� ���������� ����
-- �⵵�� Ű����� �Է¹޾Ƽ� �츦 �˾ƺ��� �ֵ��� �����ϱ�
ACCEPT K_YEAR PROMPT '���� 4�ڸ��� �Է����ּ���';
DECLARE
    V_YEAR NUMBER(4) := 2023;
    V_MOD NUMBER(2) := MOD(V_YEAR, 12); -- �⵵�� 12�� ���� ������
    V_DDI VARCHAR2(10); -- �츦 ���ؼ� ����
BEGIN
    IF V_MOD = 0 THEN V_DDI := '������';
    ELSIF V_MOD = 1 THEN V_DDI := '��';
    ELSIF V_MOD = 2 THEN V_DDI := '��';
    ELSIF V_MOD = 3 THEN V_DDI := '����';
    ELSIF V_MOD = 4 THEN V_DDI := '��';
    ELSIF V_MOD= 5 THEN V_DDI := '��';
    ELSIF V_MOD = 6 THEN V_DDI := 'ȣ����';
    ELSIF V_MOD = 7 THEN V_DDI := '�䳢';
    ELSIF V_MOD = 8 THEN V_DDI := '��';
    ELSIF V_MOD = 9 THEN V_DDI := '��';
    ELSIF V_MOD = 10 THEN V_DDI := '��';
    ELSIF V_MOD = 11 THEN V_DDI := '��';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(V_YEAR||'�� ����'||V_DDI||'�Դϴ�'); 
END;
/

-- ���ڸ� �Է¹޾� 12�Է½� 12�� ¦���Գ���, 11�Է½� 11�� Ȧ���Դϴ� ���
ACCEPT k_SU PROMPT '���� 4�ڸ� ���� �Է�';
DECLARE
    V_SU NUMBER(10) := '&K_SU';
    V_RES VARCHAR2(10) := '¦��';
BEGIN
    IF MOD(V_SU, 2) = 1 THEN V_RES := 'Ȧ��';
    ELSE V_RES := '¦��';
    
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(V_SU||'�� '||V_RES||'�Դϴ�'); 
END;
/

/*
    �ݺ���
    LOOP
        ���ɵ�;
        EXIT WITH ����;
    END LOOP
*/

ACCEPT k_DAN PROMPT '������ ���ڸ� �Է����ּ���';
DECLARE
    V_DAN NUMBER(3) := '&K_DAN';
    V_IDX NUMBER(1) := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE('** ['||V_DAN||'��] **');
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(V_DAN||' X '||V_IDX||' = '||V_DAN * V_IDX);
        V_IDX := V_IDX + 1;
        EXIT WHEN V_IDX > 9;
    END LOOP;
END;
/

/*
    �� �ٸ� ���ǹ� CASE
    
    ���� :=
        CASE ǥ����
            WHEN ��1 THEN ���1
            WHEN ��2 THEN ���2
            WHEN ��3 THEN ���3
            ELSE ���4
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
        DBMS_OUTPUT.PUT_LINE(V_GRADE||'������ '||V_MSG);
END;
/

ACCEPT K_SANGPUM PROMPT '������ ��ǰ�� �޾ƿ���';
DECLARE
    V_SANGPUM VARCHAR2(30) := '&K_SANGPUM'; -- Ű���� �Է½� ������ ��ǰ��
    V_SU NUMBER(3);
    V_DAN NUMBER(7);
    V_NUM NUMBER(3); 
BEGIN
    SELECT NUM, SU, DAN
    INTO V_NUM, V_SU, V_DAN
    FROM SHOP WHERE SANGPUM = V_SANGPUM;
    DBMS_OUTPUT.PUT_LINE(V_SANGPUM||'��ǰ����');
    DBMS_OUTPUT.PUT_LINE('��������: '||V_NUM);
    DBMS_OUTPUT.PUT_LINE('�� ��: '||V_SU);
    DBMS_OUTPUT.PUT_LINE('�� ��: '||V_DAN);
    DBMS_OUTPUT.PUT_LINE('�ѱݾ�: '||V_SU * V_DAN);
    
    -- ����Ŭ���� ���� ó���ϴ� ���
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE(V_SANGPUM||' ��ǰ�� DB�� �����ϴ�!');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('���� �߻�!');
END;
/

-- SHOP ���̺� ����
-- SHOP ���̺��� COLOR �÷��� �߰��ϰ� �⺻���� 'GREEN'
ALTER TABLE SHOP ADD COLOR VARCHAR2(20) DEFAULT 'GREEN';
-- 3���� PINK�� ����, 5���� YELLOW�� ����
UPDATE SHOP SET COLOR = 'PINK' WHERE NUM = 3;
UPDATE SHOP SET COLOR = 'YELLOW' WHERE NUM = 5;
-- ������ �߰�: �ߺ��� ��ǰ���� �־����
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL, '�����', 3, 15500, SYSDATE, 'ORANGE');
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL, '�����', 3, 21000, SYSDATE, 'BLACK');
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL, '�ݹ���', 3, 12000, SYSDATE, 'KARKI');
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL, '�ݹ���', 3, 12000, SYSDATE, 'GRAY');
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL, '�����', 3, 33000, SYSDATE, 'BLACK');
COMMIT;

/*
    FOR �ݺ���
    FOR ������ IN [REVERSE] ���۰�..������ LOOP
        �����;
    END LOOP;
*/

DECLARE
    V_BDAN NUMBER(5) := '&K_BDAN';
    V_NUM NUMBER(2);
BEGIN
    DBMS_OUTPUT.PUT_LINE(V_BDAN||'��');
    FOR V_NUM IN 1..9 LOOP
        DBMS_OUTPUT.PUT_LINE(V_BDAN||' X '||V_NUM||' = '||V_BDAN * V_NUM);
    END LOOP;
END;
/

-- DB�� Ÿ���� �����ϴ� ���
-- DB�� �����͸� ��ũ�� ������ �������� ���
DECLARE
    V_SANG SHOP.SANGPUM%TYPE := 'û����'; -- DB�� SANGPUM Ÿ���� ����
    V_SHOP ANGEL.SHOP%ROWTYPE; -- ���ڵ������ �����͸� ���� ���� ����
    
BEGIN
    SELECT * 
    INTO V_SHOP
    FROM SHOP
    WHERE SANGPUM = V_SANG;
    
    DBMS_OUTPUT.PUT_LINE('��ǰ��: '||V_SHOP.SANGPUM);
    DBMS_OUTPUT.PUT_LINE('�� ��: '||V_SHOP.COLOR);
    DBMS_OUTPUT.PUT_LINE('�� ��: '||V_SHOP.SU);
    DBMS_OUTPUT.PUT_LINE('�� ��: '||V_SHOP.DAN);
    DBMS_OUTPUT.PUT_LINE('������: '||V_SHOP.TODAY);
END;
/

/*
    ���� ���ڵ� ��ȸ��
    CURSOR Ŀ����
    IS
    SELECT ����; --SELECT ��ȸ�� ����� CURSOR�� ����
    
    FOR ���ڵ�� IN Ŀ����
*/

-- SHOP ��ü ������ ���
DECLARE
    CURSOR S1
    IS
    SELECT * FROM SHOP ORDER BY DAN DESC;
    
    V_CNT NUMBER(5);
BEGIN
    DBMS_OUTPUT.PUT_LINE('��ȣ    ��ǰ��    ����   ����   �ܰ�    ������');
    FOR S IN S1 LOOP
        DBMS_OUTPUT.PUT_LINE(S.NUM||'   '||S.SANGPUM||'   '||S.COLOR||'   '||
            S.SU||'   '||S.DAN||'   '||S.TODAY);
    END LOOP;
    
    SELECT COUNT(*) INTO V_CNT FROM SHOP;
    DBMS_OUTPUT.PUT_LINE('�� '||V_CNT||'���� ��ǰ�� �ֽ��ϴ�');
END;
/

/*
    Ű����� ��ǰ�� �Ϻθ� �Է¹޾� �ش� ��ǰ���� ����Ͻÿ�
    
    ���� ��ǰ���� '����' ��� �Է½� 
    �� N���� ��ǰ�� �ֽ��ϴ�
    
    ��ǰ��: û����
    ����: YELLOW
    �ܰ�: 23000
    
    ��ǰ��: �ݹ���
    ����: GRAY
    �ܰ�: 15000
    .
    .
    ���� ���� ��� ���� ��ǰ�� ��Ͽ� �����ϴ� �� ���
*/
ACCEPT K_PRODUCT PROMPT 'ã������ ��ǰ���� �Ϻθ� �Է����ּ���';
DECLARE
    V_PRODUCT VARCHAR(30) := '&K_PRODUCT';
    CURSOR S2
    IS
    SELECT * FROM SHOP WHERE SANGPUM LIKE '%'||V_PRODUCT||'%';
    
    V_COUNT NUMBER(3);
BEGIN
    SELECT COUNT(*) INTO V_COUNT FROM SHOP WHERE SANGPUM LIKE '%'||V_PRODUCT||'%';
    IF V_COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE(V_PRODUCT||'�� ���õ� ��ǰ�� �����ϴ�');
    ELSE
        DBMS_OUTPUT.PUT_LINE(V_COUNT||'���� �ֽ��ϴ�');
        FOR S IN S2 LOOP
            DBMS_OUTPUT.PUT_LINE('��ǰ��: '||S.SANGPUM);
            DBMS_OUTPUT.PUT_LINE('�� ��: '||S.COLOR);
            DBMS_OUTPUT.PUT_LINE('�� ��: '||S.DAN);
            DBMS_OUTPUT.PUT_LINE('-------------');
        END LOOP;
    END IF; 
END;
/

/*
CREATE [OR REPLACE] 



*/

-- ���ο� ���ν��� ����
CREATE OR REPLACE PROCEDURE MYTEST
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('ù ���ν��� ����!!');
END;
/

-- MYTEST ���ν��� ȣ��
EXEC MYTEST;

-- �������� ����ϴ� ���ν��� ����
CREATE OR REPLACE PROCEDURE GUGU(DAN NUMBER)
IS
BEGIN
    IF DAN < 2 OR DAN > 9 THEN
        DBMS_OUTPUT.PUT_LINE('���� ���');
    ELSE
        DBMS_OUTPUT.PUT_LINE(' ** '||DAN||' ** ');
        DBMS_OUTPUT.PUT_LINE('  ');
        FOR A IN 1..9 LOOP
            DBMS_OUTPUT.PUT_LINE(DAN||' X '||A||' = '||DAN * A);
        END LOOP;
    END IF;
END;
/

-- GUGU ����
EXEC GUGU(5);

-- shop�� ��ǰ�� �߰��ϴ� ���ν���
CREATE OR REPLACE PROCEDURE ADDSHOP (
    SANGPUM SHOP.SANGPUM%TYPE, SU SHOP.SU%TYPE,
    DAN SHOP.DAN%TYPE, COLOR SHOP.COLOR%TYPE
)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('SHOP DB �� '||SANGPUM||' �����͸� �߰��մϴ�');
    INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL, SANGPUM, SU, DAN, SYSDATE, COLOR);
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT||'���� ��ǰ�� �߰��Ǿ����ϴ�');
END;
/

-- ��ǰ�߰�
EXEC ADDSHOP('�����', 1, 200000, 'WHITE');

/*
    EXEC SERCHSANGPUM('�����');
    
    ��ǰ�� ���� �ܰ�
*/
--ACCEPT K_PS PROMPT '�˻��� �ܾ� �Է�';
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
        DBMS_OUTPUT.PUT_LINE(V_SANG||' ���� ��ǰ�� �����ϴ�');
    ELSE
        FOR S IN S3 LOOP
            DBMS_OUTPUT.PUT_LINE('��ǰ��: '||S.SANGPUM);
            DBMS_OUTPUT.PUT_LINE('�� ��: '||S.COLOR);
            DBMS_OUTPUT.PUT_LINE('�� ��: '||S.DAN);
            DBMS_OUTPUT.PUT_LINE('-------------');
        END LOOP;
    END IF;
END;
/

EXEC SERCHSANGPUM('����');