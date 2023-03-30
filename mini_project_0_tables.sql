drop table charger_certi;
drop table charger_port;
drop table charger;

CREATE TABLE if not exists `charger` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `max_watt` INT NOT NULL,
  `img_src` VARCHAR(200),
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE if not exists `charger_port` (
  `port_id` INT NOT NULL,
  `port_cnt` INT,
  `port_type_c` INT,
  `port_type_a` INT,
  `port_info` VARCHAR(1000) NULL,
  PRIMARY KEY (`port_id`),
  CONSTRAINT `port_id`
    FOREIGN KEY (`port_id`)
    REFERENCES `p0`.`charger` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE if not exists `charger_certi` (
  `certi_id` INT NOT NULL,
  `certification` VARCHAR(200) NULL,
  PRIMARY KEY (`certi_id`),
  CONSTRAINT `certi_id`
    FOREIGN KEY (`certi_id`)
    REFERENCES `p0`.`charger` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;



-- alter table charger modify img_src varchar(500);
-- alter table charger_port modify port_cnt int;