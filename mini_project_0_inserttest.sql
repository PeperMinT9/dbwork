insert into charger values (null, 'pd-088pt', 240, 'pd-088pt.jpg');
insert into charger_port values (1, 4, 3, 1,
'
USB-C1: 3.3V-21V/5A | 5V/3A | 9V/3A | 12V/3A | 15V/3A | 20V/5A | 28V/5A (MAX 140W),
USB-C2/C3: 3.3V-21V/5A | 5V/3A | 9V/3A | 12V/3A | 15V/3A | 20V/5A (MAX 100W),
USB-A1: 4.5V/5A | 5V/4.5A | 5V/3A | 9V/3A | 12V/3A | 15V/2A | 20V/1.5A (MAX 30W),
USB-C1 + USB-C2/C3: 140W + 100W,
USB-C1 + USB-A: 140W + 30W,
USB-C2 + USB-C3: 65W + 35W,
USB-C2/C3 + USB-A: 65W + 30W,
USB-C1 + USB-C2 + USB-C3: 140W + 65W + 35W,
USB-C1 + USB-C2/C3 + USB-A: 140W + 65W + 30W,
USB-C2 + USB-C3 + USB-A: 45W + 35W + 18W,
USB-C1 + USB-C2 + USB-C3 + USB-A:140W 45W 35W 18W
');
insert into charger_certi values (1, 'ROHS, CE, KC, ETL, FCC');

insert into charger values (null, 'pd-085pt', 200, 'pd-085pt.jpg');
insert into charger_port values (2, 5, 3, 2,
'
C1/C2/C3: 3.3V-21V/5A | 5V/3A | 9V/3A, 12V/3A | 15V/3A | 20V/5A | PPS:3.3-21V/5A (MAX 100W),
A1/A2 scp & QC: 4.5V/5A | 5V/4.5A | 9V/3A | 12V/3A | 20V/3A (MAX 60W),
C1 + C2 or C1 + C3 or C2 + C3: 100W + 100W,
C1 + A1/A2 or C2 + A1/A2 or C3 + A1: 100W + 60W,
C3 + A2: 12W + 12W,
A1 + A2: 60W + 60W,
C1 + C2 + C3: 65W + 65W + 65W,
C1 + C2 + A1 or C1 + C2 + A2 or C2 + C3 + A1: 65W + 65W + 60W, 
C1 + A1 + A2 or C2 + A1 + A2: 65W + 60W + 60W,
C3 + A1 + A2: 12W + 60W + 12W,
C1 + C2 + C3 + A1: 65W + 65W + 45W + 30W,
C1 + C2 + A1 + A2: 65W + 65W + 30W + 30W,
C2 + C3 + A1 + A2: 65W + 12W + 60W + 12W,
C1 + C2 + C3 + A1 + A2: 100W + 45W + 12W + 30W + 12W
');
insert into charger_certi values (2, 'CE, FCC, CB, PSE, RoHS');

insert into charger values (null, 'pd-077pt', 120, 'pd-077pt.jpg');
insert into charger_port values (3, 4, 3, 1,
'
USB-C1: 5V/3A | 9V/3A | 12V/3A | 15V/3A | 20V/5A (MAX 100W),
USB-C2: 5V/3A | 9V/3A | 12V/3A | 15V/3A | 20V/5A (MAX 100W),
USB-C3: 5V/3A | 9V/3A | 12V/3A | 15V/2A (MAX 30W),
USB-A scp & QC: 4.5V/5A | 5V/4.5A | 9V/3A | 12V/2.5A | 20V/1.5A (MAX 30W),
USB-C1 + USB-C2: 90W + 30W,
USB-C1 + USB-C3:90W + 30W,
USB-C1 + USB-A: 90W + 30W,
USB-C2 + USB-C3: 90W + 30W,
USB-C2 + USB-A: 90W + 30W,
USB-C3 + USB-A: 15W + 15W,
USB-C1 USB-C2 + USB-C3: 65W + 30W + 18W,
USB-C1 USB-C2 + USB-A: 65W + 30W + 18W,
USB-C1 + USB-C3 + USB-A: 90W + 15W,
USB-C2 + USB-C3 + USB-A: 90W + 15W,
USB-C1 + USB-C2 + USB-C3 + USB-A: 65W + 30W + 15W
');
insert into charger_certi values (3, 'ETL, FCC, CB, PSE');

-- 테이블 구조 변경으로 아래내용 최신화 필요
-- update charger set max_watt = 130 where id = 3;
-- update charger_port set port_info = 'C1/C2/C3: 3.3V-21V/5A | 5V/3A | 9V/3A, 12V/3A | 15V/3A | 20V/5A | PPS:3.3-21V/5A (MAX 100W),
-- A1/A2 scp & QC: 4.5V/5A | 5V/4.5A | 9V/3A | 12V/3A | 20V/3A (MAX 60W),
-- C1 + C2 or C1 + C3 or C2 + C3: 100W + 100W,
-- C1 + A1/A2 or C2 + A1/A2 or C3 + A1: 100W + 60W,
-- C3 + A2: 12W + 12W,
-- A1 + A2: 60W + 60W,
-- C1 + C2 + C3: 65W + 65W + 65W,
-- C1 + C2 + A1 or C1 + C2 + A2 or C2 + C3 + A1: 65W + 65W + 60W, 
-- C1 + A1 + A2 or C2 + A1 + A2: 65W + 60W + 60W,
-- C3 + A1 + A2: 12W + 60W + 12W,
-- C1 + C2 + C3 + A1: 65W + 65W + 45W + 30W,
-- C1 + C2 + A1 + A2: 65W + 65W + 30W + 30W,
-- C2 + C3 + A1 + A2: 65W + 12W + 60W + 12W,
-- C1 + C2 + C3 + A1 + A2: 100W + 45W + 12W + 30W + 12W' where id = 2;