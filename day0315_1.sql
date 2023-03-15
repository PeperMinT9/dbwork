-- ����
-- ���̺� ����(student): num ����(5), name ���ڿ�(10), height ����(5, 1),
-- java ����(3) �⺻�� 10, spring ����(3) �⺻�� 10, ban ���ڿ�(20)
CREATE TABLE STUDENT (
    NUM NUMBER(5),
    NAME VARCHAR2(10),
    HEIGHT NUMBER(5, 1),
    JAVA NUMBER(3) DEFAULT 10,
    SPRING NUMBER(3) DEFAULT 10,
    BAN VARCHAR2(20)
);

DROP TABLE STUDENT;

-- ������ ���� seq_stu �⺻(1���� 1������), nocache �߰�
CREATE SEQUENCE SEQ_STU START WITH 1 INCREMENT BY 1 NOCACHE;

DROP SEQUENCE SEQ_STU;

-- �������ǵ� �߰�
-- num�� primary key �߰�
ALTER TABLE STUDENT ADD CONSTRAINT STUDENT_PK_NUM PRIMARY KEY(NUM);
-- java, spring �� 1~100�� �����ϵ��� check ���� ���� �߰�
ALTER TABLE STUDENT ADD CONSTRAINT STUDENT_CK_JS CHECK (JAVA >= 1 AND JAVA <= 100 AND SPRING >= 1 AND SPRING <= 100);
-- ban�� '1��', '2��', '3��'�� �߰��Ҽ� �ֵ��� check �߰�
ALTER TABLE STUDENT ADD CONSTRAINT STUDENT_CK_BAN CHECK (BAN IN ('1��', '2��', '3��'));

-- 5�� ������ �����͸� �߰��غ� ��
insert into student (num, name, java, height, ban) VALUES (SEQ_STU.NEXTVAL, '�ƹ���', 37, 167.5, '1��');
insert into student VALUES (SEQ_STU.NEXTVAL, '�̹���', 167.5, 62, 23, '2��');
insert into student VALUES (SEQ_STU.NEXTVAL, '�蹫��', 145.8, 75, 65, '3��');
insert into student VALUES (SEQ_STU.NEXTVAL, '�ڹ���', 194.2, 63, 41, '2��');
insert into student VALUES (SEQ_STU.NEXTVAL, '�ѹ���', 161.9, 90, 88, '1��');

-- NUM�� 3�� ����� JAVA������ 99��, BAN�� '2��'����
UPDATE STUDENT SET JAVA = 99, BAN = '2��' WHERE NUM = 3;
-- NUM�� 5 �λ���� Ű�� 188.9�� ����
UPDATE STUDENT SET HEIGHT = 188.9 WHERE NUM = 5;
-- NUM = 2 �� ������ ����
DELETE FROM STUDENT WHERE NUM = 2;
-- ��ȸ �̸� �� �ڹ� ������ ���� ��� - ������ ����������� ���
SELECT NAME, BAN, JAVA, SPRING, (JAVA + SPRING) AS SUM, (JAVA + SPRING)/2 AS AVG FROM STUDENT ORDER BY (JAVA + SPRING) DESC;

COMMIT;

-- DB ����ȭ(Normalization)
-- ����ȭ�� �Ѹ���� DB������ �޸𸮸� �������� �ʱ� ���ؼ� � ���̺��� �ĺ��ڸ� ������ �������� ���̺�� ������ ����
-- ����ȭ�� DB�� �ߺ��� �ּ�ȭ�ǵ��� ����� �����ͺ��̽��̴�
-- ����: �޸𸮸� ������ �� �ִ�. ����ȭ�� �ý������� ���ؼ� ������ ���ϴ�
-- ����: ��ȸ������ �ſ� ���� �ý����� ��쿡�� ���̺��� JOIN������ �ݺ������� �̷����� ������ ���� ���� �ӵ��� ��������

-- STUDENT�� NUM�� �ܺ�Ű�� ���� ���ο� ���̺� STUINFO�� ������
-- �ܺ�Ű�� ���̺� ������ �����ص� �ǰ� �ϴ� ������ ���̺� �������� �߰��ص� �ȴ�

-- PPT 29������
CREATE TABLE STUINFO (
    IDX NUMBER(5) CONSTRAINT INFO_PK_IDX PRIMARY KEY,
    NUM NUMBER(5),
    ADDR VARCHAR2(20),
    PN VARCHAR2(15)
);


-- �ܺ�Ű �������� �߰�
-- STUINFO�� NUM�� STUDENT�� NUM���� ���� �� �ֵ��� ����
ALTER TABLE STUINFO ADD CONSTRAINT INFO_FK_NUM FOREIGN KEY(NUM) REFERENCES STUDENT(NUM);

-- STUINFO�� NUM�� ���� 3�� �߰��ߴٸ� STUDENT���̺��� NUM = 3�� �����ʹ� ������ �� ����
-- �� �������� �߰��� ON DELETE CASCADE�� �߰�������� �θ����̺��� NUM = 3�� ������ ������ STUINFO�� NUM 3 �� �����ʹ� �ڵ� �����ȴ�

-- STUINFO�� ������ �߰��ϱ�
INSERT INTO STUINFO VALUES (SEQ_STU.NEXTVAL, 3, '����� ������', '010-2222-3333');
-- STUINFO�� ���� 2���� �߰��غ���
-- ORA-02291: ���Ἲ ��������(ANGEL.INFO_FK_NUM)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�
INSERT INTO STUINFO VALUES (SEQ_STU.NEXTVAL, 2, '����� ������', '010-2222-3333');
-- �ٽ� 4������
INSERT INTO STUINFO VALUES (SEQ_STU.NEXTVAL, 4, '����� ������', '010-3333-2222');
INSERT INTO STUINFO VALUES (SEQ_STU.NEXTVAL, 1, '�뱸�� �߱�', '010-4444-5555');
COMMIT;

-- ��ȸ
-- ���� ��ȸ�� �Ұܿ� ��� ������ �˼�����
SELECT * FROM STUINFO;

-- JOIN���� �� ���̺��� ���ؼ� �ʿ��� ������ �����ͺ���
-- PPT 43������
-- INNER JOIN �Ǵ� EQUI JOIN �̶�� �Ѵ�. ���� NUM���� ������쿡�� �����´�
SELECT SD.NUM ������, SD.NAME AS �л���, SD.HEIGHT AS Ű, SD.BAN AS ��, 
    SI.ADDR AS �ּ�, SI.PN AS �ڵ���, SD.JAVA �ڹ�, SD.SPRING ������
    FROM STUDENT SD, STUINFO SI WHERE SD.NUM = SI.NUM;
    
-- �̶� ���� ���̺� ���������� ���� �ִ� �÷��� �����ϰ�� �տ� ���̺�� ���� ����
SELECT SD.NUM ������, NAME AS �л���, HEIGHT AS Ű, BAN AS ��, 
    ADDR AS �ּ�, PN AS �ڵ���, JAVA �ڹ�, SPRING ������
    FROM STUDENT SD, STUINFO SI WHERE SD.NUM = SI.NUM;
    
-- outer join ���� �߰����� ���� �����͸� ã�ƺ���
-- sub ���̺��ʿ� (+)
-- �̶� ���� ���̺� ���������� ���� �ִ� �÷��� �����ϰ�� �տ� ���̺�� ���� ����
SELECT SD.NUM ������, NAME AS �л���, HEIGHT AS Ű, BAN AS ��, 
    ADDR AS �ּ�, PN AS �ڵ���, JAVA �ڹ�, SPRING ������
    FROM STUDENT SD, STUINFO SI WHERE SD.NUM = SI.NUM(+) and addr is null;
    
-- student ���̺��� num = 1�� ������ �����غ���
-- ORA-02292: ���Ἲ ��������(ANGEL.INFO_FK_NUM)�� ����Ǿ����ϴ�- �ڽ� ���ڵ尡 �߰ߵǾ����ϴ�
-- �� ��� ���� ������ �ϰ������ stuinfo�� �����͸� ���� ������ student�� �����͸� �����Ҽ��ִ�.
delete from student where num = 1;

-- sub ���̺��� num = 1 ���� ������ �θ����̺��� num = 1�� �����غ���
delete from stuinfo where num = 1;
delete from student where num = 1;

-- ���̺� ���Ž� �������̺��� ���� ������ �θ� ���̺� ����
drop table stuinfo;
drop table student;

---------------------------------------------------------------------------------------------------

-- �̹����� �θ����̺��� ������ ������ �������̺��� �����͵� �ڵ����� �����ǵ���
-- �ܺ�Ű�� �����غ���
-- ������ ����
CREATE SEQUENCE SEQ_SHOP;
-- SHOP, CART
CREATE TABLE SHOP (
    SANG_NO NUMBER(3) CONSTRAINT SHOP_PK_NO PRIMARY KEY,
    SANG_NAME VARCHAR2(30),
    SANG_PRICE NUMBER(10)
);

-- �ܺ�Ű ������ ON DELETE CASCADE�� ���̸� �θ����̺� ������ �ڽ����̺� �߰��� �����͵� ���� ������
CREATE TABLE CART (
    CART_NO NUMBER(3) CONSTRAINT CART_PK_NO PRIMARY KEY,
    SANG_NO NUMBER(3),
    CNT NUMBER(3),
    CARTDAY DATE,
    CONSTRAINT CART_FK_NO FOREIGN KEY(SANG_NO) REFERENCES SHOP(SANG_NO) ON DELETE CASCADE
);

-- 5���� ��ǰ�� ����غ���
INSERT INTO SHOP VALUES (SEQ_SHOP.NEXTVAL, '���콺', 12000);
INSERT INTO SHOP VALUES (SEQ_SHOP.NEXTVAL, '����', 18000);
INSERT INTO SHOP VALUES (SEQ_SHOP.NEXTVAL, '����', 87000);
INSERT INTO SHOP VALUES (SEQ_SHOP.NEXTVAL, '�е�', 99000);
INSERT INTO SHOP VALUES (SEQ_SHOP.NEXTVAL, '��Ʈ', 120000);
COMMIT;

INSERT INTO CART VALUES (SEQ_SHOP.NEXTVAL, 2, 3, SYSDATE);
INSERT INTO CART VALUES (SEQ_SHOP.NEXTVAL, 3, 1, '2021-01-13');
INSERT INTO CART VALUES (SEQ_SHOP.NEXTVAL, 5, 3, SYSDATE);
COMMIT;

-- ��ȸ
-- SANG_NO ��ǰ��ȣ, ��ǰ��, �ܰ�, ����, ������(��4-��2-��2 �������� ���)
SELECT SH.SANG_NO AS ��ǰ��ȣ, SANG_NAME AS ��ǰ��, TO_CHAR(SANG_PRICE, 'l999,999') AS �ܰ�, 
    CNT AS ����, TO_CHAR(CARTDAY, 'YYYY-MM-DD') AS ������
    FROM SHOP SH, CART CA WHERE SH.SANG_NO = CA.SANG_NO;
-- CART�� ����� ���� ��ǰ�� ��ǰ��ȣ�� ��ǰ�� ���
SELECT SH.SANG_NO AS ��ǰ��ȣ, SANG_NAME AS ��ǰ�� 
    FROM SHOP SH, CART CA WHERE SH.SANG_NO = CA.SANG_NO(+) AND CNT IS NULL;
    
-- ������ Ȯ��(2, 3, 5 ��ǰ�� CART�� �������)
-- SHOP�� 2��, 3�� ��ǰ�� ������ CART ���̺��� Ȯ��
DELETE FROM SHOP WHERE SANG_NO = 2 OR SANG_NO = 3;
SELECT * FROM CART;

-- ���� ������ ��� ���̺�� �������� �������ּ���
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

INSERT INTO RESTAURANT VALUES (SEQ_FOOD.NEXTVAL, '���İ�Ƽ', 23000);
INSERT INTO RESTAURANT VALUES (SEQ_FOOD.NEXTVAL, '���캺����', 11000);
INSERT INTO RESTAURANT VALUES (SEQ_FOOD.NEXTVAL, '������', 19000);
INSERT INTO RESTAURANT VALUES (SEQ_FOOD.NEXTVAL, '����Ƣ��', 10000);
INSERT INTO RESTAURANT VALUES (SEQ_FOOD.NEXTVAL, '¥���', 5000);

INSERT INTO RESORDER VALUES (SEQ_FOOD.NEXTVAL, '�̹���', 1, '2023-11-20', SYSDATE, 4);
INSERT INTO RESORDER VALUES (SEQ_FOOD.NEXTVAL, '������', 2, '2023-12-25', SYSDATE, 3);
INSERT INTO RESORDER VALUES (SEQ_FOOD.NEXTVAL, '������', 3, '2023-12-20', SYSDATE, 3);
INSERT INTO RESORDER VALUES (SEQ_FOOD.NEXTVAL, '�̹���', 1, '2023-05-11', SYSDATE, 2);

SELECT ORDER_NAME AS �ֹ���, ORDER_DAY AS ������, RS.FOOD_NAME AS ���ĸ�,
    RS.FOOD_PRICE AS ���İ���, TO_CHAR(JUMUN_DAY, 'YYYY-MM-DD') AS �ֹ���, INWON AS �ο���
    FROM RESTAURANT RS, RESORDER RO WHERE RS.FOOD_NUM = RO.FOOD_NUM;
    
DELETE FROM RESTAURANT WHERE FOOD_NAME = '������';

SELECT * FROM RESTAURANT;
SELECT * FROM RESORDER;