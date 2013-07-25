SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `gwtwebdata` DEFAULT CHARACTER SET utf8 ;
USE `gwtwebdata` ;

-- -----------------------------------------------------
-- Table `gwtwebdata`.`profile`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `gwtwebdata`.`profile` (
  `id_profile` INT(11) NOT NULL ,
  `name_profile` VARCHAR(45) NULL ,
  `slide_show` VARCHAR(45) NULL ,
  `background` VARCHAR(45) NULL ,
  `fontFamily` VARCHAR(45) NULL ,
  `fontStyle` VARCHAR(45) NULL ,
  `fontColor` VARCHAR(45) NULL ,
  `colum` INT(11) NULL ,
  `fontSize` INT(11) NULL ,
  PRIMARY KEY (`id_profile`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `gwtwebdata`.`user`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `gwtwebdata`.`user` (
  `id_user` INT(11) NOT NULL AUTO_INCREMENT ,
  `nick_name` VARCHAR(45) NOT NULL ,
  `email` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(45) NOT NULL ,
  `provider` INT(11) NOT NULL ,
  `id_score` INT(11) NULL ,
  `register_date` DATE NULL ,
  `isadmin` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`id_user`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `gwtwebdata`.`admin_profile`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `gwtwebdata`.`admin_profile` (
  `user_id_user` INT(11) NOT NULL ,
  `id_profile` INT(11) NOT NULL ,
  INDEX `fk_admin_profile_profile1_idx` (`id_profile` ASC) ,
  PRIMARY KEY (`user_id_user`) ,
  CONSTRAINT `fk_admin_profile_profile1`
    FOREIGN KEY (`id_profile` )
    REFERENCES `gwtwebdata`.`profile` (`id_profile` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_admin_profile_user1`
    FOREIGN KEY (`user_id_user` )
    REFERENCES `gwtwebdata`.`user` (`id_user` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `gwtwebdata`.`baner_image`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `gwtwebdata`.`baner_image` (
  `id_baner` INT(11) NOT NULL AUTO_INCREMENT ,
  `baner_url` VARCHAR(300) NULL DEFAULT NULL ,
  `id_profile` INT(11) NOT NULL ,
  PRIMARY KEY (`id_baner`) ,
  INDEX `fk_baner_image_profile1_idx` (`id_profile` ASC) ,
  CONSTRAINT `fk_baner_image_profile1`
    FOREIGN KEY (`id_profile` )
    REFERENCES `gwtwebdata`.`profile` (`id_profile` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `gwtwebdata`.`category`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `gwtwebdata`.`category` (
  `id` INT(11) NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `description` VARCHAR(45) NOT NULL ,
  `create_date` DATE NOT NULL ,
  `uncategorized` TINYINT(1) NOT NULL ,
  `main_category` TINYINT(1) NOT NULL ,
  `level_category` INT(11) NOT NULL ,
  `avatar_url` VARCHAR(300) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `gwtwebdata`.`payments`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `gwtwebdata`.`payments` (
  `id_payment` INT(11) NOT NULL ,
  `payments` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`id_payment`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `gwtwebdata`.`customer`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `gwtwebdata`.`customer` (
  `id_customer` INT(11) NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `address` VARCHAR(200) NOT NULL ,
  `email` VARCHAR(45) NOT NULL ,
  `phone_number` VARCHAR(10) NOT NULL ,
  `id_payment` INT(11) NOT NULL ,
  PRIMARY KEY (`id_customer`) ,
  INDEX `fk_customer_payments1_idx` (`id_payment` ASC) ,
  CONSTRAINT `fk_customer_payments1`
    FOREIGN KEY (`id_payment` )
    REFERENCES `gwtwebdata`.`payments` (`id_payment` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `gwtwebdata`.`order`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `gwtwebdata`.`order` (
  `id_order` INT(11) NOT NULL AUTO_INCREMENT ,
  `quantity` INT(11) NOT NULL ,
  `create_date` DATETIME NOT NULL ,
  PRIMARY KEY (`id_order`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `gwtwebdata`.`picture`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `gwtwebdata`.`picture` (
  `id_picture` INT(11) NOT NULL AUTO_INCREMENT ,
  `picture_url` VARCHAR(300) NULL ,
  `id_profile` INT(11) NOT NULL ,
  PRIMARY KEY (`id_picture`) ,
  INDEX `fk_picture_profile_idx` (`id_profile` ASC) ,
  CONSTRAINT `fk_picture_profile`
    FOREIGN KEY (`id_profile` )
    REFERENCES `gwtwebdata`.`profile` (`id_profile` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `gwtwebdata`.`product`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `gwtwebdata`.`product` (
  `id_product` INT(11) NOT NULL AUTO_INCREMENT ,
  `id_category_parent` INT(11) NOT NULL ,
  `avatar_url` VARCHAR(300) NOT NULL ,
  `create_date` DATETIME NOT NULL ,
  `currency` VARCHAR(20) NOT NULL ,
  `description` VARCHAR(300) NOT NULL ,
  `price` DOUBLE NOT NULL ,
  `quantity` INT(11) NOT NULL ,
  `rate_average` DOUBLE NOT NULL ,
  `rate_count` INT(11) NOT NULL ,
  `title` VARCHAR(300) NOT NULL ,
  `total_transactions` INT(11) NOT NULL ,
  `update_date` DATETIME NOT NULL ,
  `keyword` VARCHAR(300) NOT NULL ,
  PRIMARY KEY (`id_product`) ,
  INDEX `fk_product_category1_idx` (`id_category_parent` ASC) ,
  CONSTRAINT `fk_product_category1`
    FOREIGN KEY (`id_category_parent` )
    REFERENCES `gwtwebdata`.`category` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `gwtwebdata`.`customer_order_product`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `gwtwebdata`.`customer_order_product` (
  `id_product` INT(11) NOT NULL ,
  `id_order` INT(11) NOT NULL ,
  `id_customer` INT(11) NOT NULL ,
  PRIMARY KEY (`id_product`, `id_order`, `id_customer`) ,
  INDEX `fk_product_has_order_order1_idx` (`id_order` ASC) ,
  INDEX `fk_product_has_order_product1_idx` (`id_product` ASC) ,
  INDEX `fk_product_has_order_customer1_idx` (`id_customer` ASC) ,
  CONSTRAINT `fk_product_has_order_product1`
    FOREIGN KEY (`id_product` )
    REFERENCES `gwtwebdata`.`product` (`id_product` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_has_order_order1`
    FOREIGN KEY (`id_order` )
    REFERENCES `gwtwebdata`.`order` (`id_order` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_has_order_customer1`
    FOREIGN KEY (`id_customer` )
    REFERENCES `gwtwebdata`.`customer` (`id_customer` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `gwtwebdata`.`children_category`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `gwtwebdata`.`children_category` (
  `id_next_children` INT(11) NOT NULL ,
  `category_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id_next_children`, `category_id`) ,
  INDEX `fk_children_category_category1_idx` (`category_id` ASC) ,
  CONSTRAINT `fk_children_category_category1`
    FOREIGN KEY (`category_id` )
    REFERENCES `gwtwebdata`.`category` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gwtwebdata`.`config_loaddb`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `gwtwebdata`.`config_loaddb` (
  `config_db` INT NOT NULL ,
  PRIMARY KEY (`config_db`) )
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
