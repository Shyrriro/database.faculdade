-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_faculdade
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_faculdade
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_faculdade` DEFAULT CHARACTER SET utf8 ;
USE `db_faculdade` ;

-- -----------------------------------------------------
-- Table `db_faculdade`.`tbl_departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_faculdade`.`tbl_departamento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `sigla` CHAR(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_faculdade`.`tbl_curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_faculdade`.`tbl_curso` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `codigo` VARCHAR(10) NOT NULL,
  `descricao` TEXT NULL,
  `duracao_em_semestre` INT NOT NULL COMMENT 'Duração em semestres',
  `data_criacao` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `departamento_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tbl_curso_tbl_departamento1_idx` (`departamento_id` ASC),
  CONSTRAINT `fk_tbl_curso_tbl_departamento1`
    FOREIGN KEY (`departamento_id`)
    REFERENCES `db_faculdade`.`tbl_departamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_faculdade`.`tbl_alunos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_faculdade`.`tbl_alunos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_completo` VARCHAR(255) NOT NULL,
  `data_nascimento` DATETIME NOT NULL,
  `rg` VARCHAR(12) NOT NULL,
  `cpf` VARCHAR(45) NOT NULL,
  `genero` ENUM('Masculino', 'Feminino', 'Outro') NOT NULL DEFAULT 'Outro',
  `email` VARCHAR(255) NOT NULL,
  `telefone` VARCHAR(20) NOT NULL,
  `ra` VARCHAR(10) NOT NULL,
  `endereco` VARCHAR(255) NOT NULL,
  `status` ENUM('Ativo', 'Formado', 'Transferido', 'Trancado') NOT NULL DEFAULT 'Ativo',
  `nacionalidade` VARCHAR(45) NOT NULL,
  `mensalidade` DECIMAL(10,2) NOT NULL,
  `data_matricula` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `curso_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  UNIQUE INDEX `rg_UNIQUE` (`rg` ASC),
  UNIQUE INDEX `ra_UNIQUE` (`ra` ASC),
  INDEX `fk_tbl_alunos_tbl_curso_idx` (`curso_id` ASC),
  CONSTRAINT `fk_tbl_alunos_tbl_curso`
    FOREIGN KEY (`curso_id`)
    REFERENCES `db_faculdade`.`tbl_curso` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_faculdade`.`tbl_professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_faculdade`.`tbl_professor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_completo` VARCHAR(255) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `rg` VARCHAR(12) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `telefone` VARCHAR(20) NOT NULL,
  `area_especializacao` VARCHAR(100) NOT NULL,
  `data_contratacao` DATE NOT NULL,
  `status` ENUM('Ativo', 'Inativo') NOT NULL DEFAULT 'ativo',
  `salario` DECIMAL(10,2) NOT NULL,
  `carga_horaria` INT NOT NULL,
  `departamento_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tbl_professor_tbl_departamento1_idx` (`departamento_id` ASC),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  UNIQUE INDEX `rg_UNIQUE` (`rg` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  CONSTRAINT `fk_tbl_professor_tbl_departamento1`
    FOREIGN KEY (`departamento_id`)
    REFERENCES `db_faculdade`.`tbl_departamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_faculdade`.`tbl_disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_faculdade`.`tbl_disciplina` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `carga_horaria` INT NOT NULL,
  `curso_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tbl_disciplina_tbl_curso1_idx` (`curso_id` ASC),
  CONSTRAINT `fk_tbl_disciplina_tbl_curso1`
    FOREIGN KEY (`curso_id`)
    REFERENCES `db_faculdade`.`tbl_curso` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_faculdade`.`tbl_turma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_faculdade`.`tbl_turma` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `turma` VARCHAR(45) NOT NULL,
  `semestre` INT NOT NULL,
  `ano` INT NOT NULL,
  `departamento_id` INT NOT NULL,
  `professor_id` INT NOT NULL,
  `disciplina_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tbl_turma_tbl_departamento1_idx` (`departamento_id` ASC),
  INDEX `fk_tbl_turma_tbl_professor1_idx` (`professor_id` ASC),
  INDEX `fk_tbl_turma_tbl_disciplina1_idx` (`disciplina_id` ASC),
  CONSTRAINT `fk_tbl_turma_tbl_departamento1`
    FOREIGN KEY (`departamento_id`)
    REFERENCES `db_faculdade`.`tbl_departamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_turma_tbl_professor1`
    FOREIGN KEY (`professor_id`)
    REFERENCES `db_faculdade`.`tbl_professor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_turma_tbl_disciplina1`
    FOREIGN KEY (`disciplina_id`)
    REFERENCES `db_faculdade`.`tbl_disciplina` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_faculdade`.`tbl_matricula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_faculdade`.`tbl_matricula` (
  `data` DATE NOT NULL,
  `alunos_id` INT NOT NULL,
  `turma_id` INT NOT NULL,
  INDEX `fk_tbl_matricula_tbl_alunos1_idx` (`alunos_id` ASC),
  INDEX `fk_tbl_matricula_tbl_turma1_idx` (`turma_id` ASC),
  UNIQUE INDEX `turma_id_UNIQUE` (`turma_id` ASC),
  UNIQUE INDEX `alunos_id_UNIQUE` (`alunos_id` ASC),
  CONSTRAINT `fk_tbl_matricula_tbl_alunos1`
    FOREIGN KEY (`alunos_id`)
    REFERENCES `db_faculdade`.`tbl_alunos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_matricula_tbl_turma1`
    FOREIGN KEY (`turma_id`)
    REFERENCES `db_faculdade`.`tbl_turma` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_faculdade`.`tbl_notas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_faculdade`.`tbl_notas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nota` DECIMAL(5,2) NOT NULL,
  `unidade` INT NOT NULL,
  `disciplina_id` INT NOT NULL,
  `alunos_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tbl_notas_tbl_disciplina1_idx` (`disciplina_id` ASC),
  INDEX `fk_tbl_notas_tbl_alunos1_idx` (`alunos_id` ASC),
  CONSTRAINT `fk_tbl_notas_tbl_disciplina1`
    FOREIGN KEY (`disciplina_id`)
    REFERENCES `db_faculdade`.`tbl_disciplina` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_notas_tbl_alunos1`
    FOREIGN KEY (`alunos_id`)
    REFERENCES `db_faculdade`.`tbl_alunos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_faculdade`.`tbl_nota_final`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_faculdade`.`tbl_nota_final` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nota_final` DECIMAL(5,2) NOT NULL,
  `disciplina_id` INT NOT NULL,
  `alunos_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tbl_nota_final_tbl_alunos1_idx` (`alunos_id` ASC),
  INDEX `fk_tbl_nota_final_tbl_disciplina1_idx` (`disciplina_id` ASC),
  CONSTRAINT `fk_tbl_nota_final_tbl_alunos1`
    FOREIGN KEY (`alunos_id`)
    REFERENCES `db_faculdade`.`tbl_alunos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_nota_final_tbl_disciplina1`
    FOREIGN KEY (`disciplina_id`)
    REFERENCES `db_faculdade`.`tbl_disciplina` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
