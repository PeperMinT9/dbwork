select * from charger;
select * from charger_port;
select * from charger_certi;
select charger.id as id, name, max_watt, img_src, port_cnt, port_type_c, port_type_a, port_info, certification from charger 
join charger_port on charger.id = charger_port.id
join charger_certi on charger.id = charger_certi.id;
select charger.id, name, max_watt, port_cnt, certification from charger join charger_certi on charger.id = charger_certi.id;

SELECT LAST_INSERT_ID();

show table status where name='charger';

select * from charger order by id desc limit 1;