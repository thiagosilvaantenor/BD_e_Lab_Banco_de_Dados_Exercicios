/* Treino P2 com a database modelo*/

-- TABELA MODELO
CREATE DATABASE bd_academico;
Use bd_academico;

-- Criando tabelas:
-- Tabela Pre Requisitos
CREATE TABLE PreReq(
	codDeptoPreReq CHAR(5),
    numDiscPreReq INT,
    codDepto CHAR(5),
    numDisc	INT
);

-- Tb Disciplina
CREATE TABLE Disciplina(
	codDepto CHAR(5),
    numDisc INT,
    nomeDisc VARCHAR(10),
    creditoDisc INT
);

-- TB Depto

CREATE TABLE Depto(
	codDepto CHAR(5),
    nomeDepto VARCHAR(40)
);

-- Tb Professor
CREATE TABLE Professor(
	codProf 	INT,
    codDepto 	CHAR(5),
    codTit		INT,
    nomeProf	VARCHAR(40)
);

-- TB Titulação
CREATE TABLE Titulacao(
	codTit INT,
    nomeTit VARCHAR(40)
);

-- TB professorTurma
CREATE TABLE profTurma(
	anoSem INT,
    codDepto CHAR(5),
    numDisc INT,
    siglaTur CHAR(2),
    codProf	INT
);

-- TB Turma
CREATE TABLE Turma(
	anoSem INT,
    codDepto CHAR(5),
    numDisc	INT,
    siglaTur CHAR(2),
    capacTur INT
);

-- TB Horario
CREATE TABLE Horario(
	anoSem 		INT,
    codDepto 	CHAR(5),
    numDisc		INT,
    siglaTur 	CHAR(2),
    diaSem		INT,
    horaInicio 	INT,
    numSala		INT,
    codPred		INT,
    numHoras	INT
);

-- TB Sala
CREATE TABLE Sala(
	codPred INT,
    numSala INT,
    descricaoSala VARCHAR(40),
    capacSala INT
);

-- TB predio
CREATE TABLE Predio(
	codPred INT,
    nomePred VARCHAR(40)
);

-- PRIMARY KEY E FOREIGN KEYS
-- Depto
ALTER TABLE Depto
ADD CONSTRAINT PK_tb_depto
PRIMARY KEY (codDepto);

-- titulacao
ALTER TABLE titulacao
ADD CONSTRAINT PK_tb_titulacao
PRIMARY KEY (codTit);

-- Professor
ALTER TABLE professor
ADD CONSTRAINT PK_tb_professor
PRIMARY KEY(codProf);

ALTER TABLE professor
ADD CONSTRAINT FK_tb_professor_titulacao
FOREIGN KEY(codTit) REFERENCES titulacao(codTit);

ALTER TABLE professor
ADD CONSTRAINT FK_tb_professor_depto
FOREIGN KEY(codDepto) REFERENCES depto(codDepto);

-- Disciplina
ALTER TABLE disciplina
ADD CONSTRAINT PK_tb_disciplina
PRIMARY KEY(codDepto, numDisc);

ALTER TABLE disciplina
ADD CONSTRAINT FK_tb_disciplina_tb_depto
FOREIGN KEY(codDepto) REFERENCES depto(codDepto);

-- PreReq
ALTER TABLE PreReq
ADD CONSTRAINT PK_tb_preReq
PRIMARY KEY(codDeptoPreReq, numDiscPreReq, codDepto, NumDisc);

ALTER TABLE PreReq
ADD CONSTRAINT FK_PREREQ_EH_DISCIPLINA
FOREIGN KEY(codDepto, numDisc) 
REFERENCES Disciplina(codDepto, NumDisc);

ALTER TABLE PreReq
ADD CONSTRAINT FK_PREREQ_TEM_DISCIPLINA
FOREIGN KEY(codDeptoPreReq, numDiscPreReq) 
REFERENCES Disciplina(codDepto, NumDisc);

-- Turma
ALTER TABLE turma
ADD CONSTRAINT PK_TB_Turma
PRIMARY KEY(anoSem, CodDepto, NumDisc, SiglaTur);

ALTER TABLE turma
ADD CONSTRAINT FK_TB_TURMA_DISCIPLINA
FOREIGN KEY(codDepto, NumDisc) REFERENCES Disciplina(codDepto, NumDisc);

-- ProfTurma
ALTER TABLE profTurma
ADD CONSTRAINT PK_TB_prof_Turma
PRIMARY KEY(anoSem, codDepto, numDisc, siglaTur, codProf);

ALTER TABLE profTurma
ADD CONSTRAINT FK_TB_prof_Turma_professor
FOREIGN KEY(codProf) REFERENCES professor(codProf);

ALTER TABLE profTurma
ADD CONSTRAINT FK_TB_profTurma_Turma
FOREIGN KEY(anoSem, codDepto, numDisc, siglaTur) REFERENCES Turma(anoSem, codDepto, numDisc, siglaTur);

-- Predio
ALTER TABLE predio
ADD CONSTRAINT PK_TB_predio
PRIMARY KEY (codPred);

-- Sala
ALTER TABLE Sala
ADD CONSTRAINT PK_TB_sala
PRIMARY KEY (codPred, NumSala);

ALTER TABLE Sala
ADD CONSTRAINT FK_TB_sala_TB_predio
FOREIGN KEY (codPred) REFERENCES predio(codPred);

-- Horario
ALTER TABLE horario
ADD CONSTRAINT PK_TB_horario
PRIMARY KEY(anoSem, codDepto, numDisc, siglaTur, diaSem, horaInicio);

ALTER TABLE horario
ADD CONSTRAINT FK_TB_horario_TB_turma
FOREIGN KEY(anoSem, codDepto, numDisc, siglaTur) REFERENCES Turma(anoSem, codDepto, numDisc, siglaTur);

ALTER TABLE horario
ADD CONSTRAINT FK_TB_horario_TB_sala
FOREIGN KEY(codPred, numSala) REFERENCES Sala(codPred, numSala);

/*
I. Exercícios de Triggers

Enunciados:

1- Trigger para Capacidade de Turma: Crie um trigger que, antes de inserir ou atualizar uma turma na tabela Turma, verifique se a CapacTur 
    (capacidade da turma) é um valor positivo. Se não for, emita um erro.

2 - Trigger para Atualização de Créditos: Crie um trigger que, após uma atualização nos CreditosDisc (créditos da disciplina) na tabela Disciplina, 
	insira um registro em uma nova tabela de log chamada LogCreditosDisciplina (com colunas CodDepto, NumDisc, CreditosAntigos, CreditosNovos, DataModificacao).
    
3 - Trigger para Exclusão de Professor: Crie um trigger que, antes de excluir um professor da tabela Professor, verifique se ele está associado a alguma ProfTurma 
	(professor-turma). Se estiver, impeça a exclusão e retorne uma mensagem de erro.
*/

/* 1- Trigger para Capacidade de Turma: Crie um trigger que, antes de inserir ou atualizar uma turma na tabela Turma, verifique se a CapacTur 
    (capacidade da turma) é um valor positivo. Se não for, emita um erro.
*/ 
-- Insert
DELIMITER $
CREATE TRIGGER tg_capacidade_turma_novo BEFORE INSERT
ON turma
FOR EACH ROW
BEGIN
	IF NEW.capacTur < 0 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Erro, capacidade da turma deve ser um valor positivo';
	END IF;
END$

-- Update
DELIMITER $
CREATE TRIGGER tg_capacidade_turma_novo BEFORE UPDATE
ON turma
FOR EACH ROW
BEGIN
	IF NEW.capacTur < 0 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Erro, capacidade da turma deve ser um valor positivo';
	END IF;
END$
DELIMITER ;
/* 2 - Trigger para Atualização de Créditos: Crie um trigger que, após uma atualização nos CreditosDisc (créditos da disciplina) na tabela Disciplina, 
	insira um registro em uma nova tabela de log chamada LogCreditosDisciplina (com colunas CodDepto, NumDisc, CreditosAntigos, CreditosNovos, DataModificacao).
    */

-- Cria tabela de logs LogCreditosDisciplina (com colunas CodDepto, NumDisc, CreditosAntigos, CreditosNovos, DataModificacao)
CREATE TABLE LogCreditosDisciplina (
CodDepto CHAR(5),
NumDisc INT,
CreditosAntigos INT,
CreditosNovos INT,
DataModificacao DATE
);
-- PK
ALTER TABLE LogCreditosDisciplina
ADD CONSTRAINT PK_TB_LogCreditosDisciplina
PRIMARY KEY (CodDepto, NumDisc, DataModificacao);
-- FK
ALTER TABLE LogCreditosDisciplina
ADD CONSTRAINT FK_TB_LogCreditosDisciplina_codDepto
FOREIGN KEY (CodDepto, NumDisc) REFERENCES disciplina(codDepto, NumDisc);

-- TRIGGER
DELIMITER $
CREATE TRIGGER tg_log_creditos_disciplina AFTER UPDATE
ON disciplina FOR EACH ROW
BEGIN
	IF OLD.creditoDisc != NEW.creditoDisc THEN
		INSERT INTO logcreditosdisciplina(CodDepto, NumDisc, CreditosAntigos, CreditosNovos, DataModificacao) VALUES
		(OLD.codDepto, OLD.numDisc, OLD.creditoDisc, NEW.creditoDisc, DATE.NOW());
	END IF;
END$
-- --------------------------
/*3 - Trigger para Exclusão de Professor: Crie um trigger que, antes de excluir um professor da tabela Professor, verifique se ele está associado a alguma ProfTurma 
	(professor-turma). Se estiver, impeça a exclusão e retorne uma mensagem de erro.
*/
BEGIN TRAN
	DELIMITER $
	CREATE TRIGGER tg_verifica_prof_excluido_em_profturma BEFORE DELETE
	ON professor FOR EACH ROW
	BEGIN
		IF (SELECT COUNT(proft.codProf) FROM profTurma proft INNER JOIN professor p ON proft.codProf = p.codProf
		   WHERE prof.codProf = OLD.codProf ) > 0 THEN
		   SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Erro ao tentar excluir professor, existe uma turma associada a ele';
		END IF;
	END$
	DELIMITER ;
COMMIT;
/*
II. Exercícios de Tratamento de Exceções

Enunciados:

    1- Procedimento para Inserir Nova Disciplina: 
    Crie um procedimento armazenado que tente inserir uma nova disciplina na tabela Disciplina. 
    Implemente tratamento de exceções para lidar com o caso de uma chave primária duplicada 
    (assumindo que (CodDepto, NumDisc) é a chave primária), retornando uma mensagem amigável ao usuário.

    Função para Buscar Nome do Professor: Crie uma função que receba um CodProf e retorne o NomeProf. Inclua tratamento de exceção para o caso de o professor não ser encontrado, retornando uma mensagem apropriada ou NULL.
*/
BEGIN TRAN
	DELIMITER $
	CREATE PROCEDURE inserir_nova_disciplina(IN _codDepto CHAR(5),
    IN _numDisc INT,
    IN _nomeDisc VARCHAR(10), 
    IN creditoDisc INT)
	BEGIN
			-- Caso ocorra erro de chave duplicada
			DECLARE EXIT HANDLER FOR 1062
            BEGIN
			SELECT CONCAT('Chave primaria duplicada (', _codDepto, ',', _numDisc,')') AS erro;
			END;
		INSERT INTO disciplina(codDepto, numDisc, nomeDisc, creditoDisc)
		VALUES (_codDepto, _numDisc, _nomeDisc, creditoDisc);
        
        SELECT 'Disciplina inserida com sucesso' as mensagem;
	END$
COMMIT

/* Função para Buscar Nome do Professor: Crie uma função que receba um CodProf e retorne o NomeProf. 
Inclua tratamento de exceção para o caso de o professor não ser encontrado, retornando uma mensagem apropriada ou NULL.*/
DELIMITER ;
	DELIMITER $
    CREATE PROCEDURE pr_obter_nomeProf_com_codProf(IN _CodProf INT, OUT _nomeProf VARCHAR(40))
    BEGIN
		DECLARE EXIT HANDLER FOR NOT FOUND
        BEGIN
			SELECT 'Nenhum professor com este CodProf foi não encontrado' AS mensagemErro;
        END;
        SELECT nomeProf INTO _nomeProf from professor WHERE professor.codProf = _CodProf;
        SELECT @_nomeProf;
    END$

CALL pr_obter_nomeProf_com_codProf(5, @_nomeProf);
SELECT @_nomeProf;

- ---------
/*Tarefa 08 TRIGGER*/
/* Criar trigger para registrar um LOG das atualizações das Tabela Professor. No Log deve existir:

       1-  código do usuário que fez a alteração;

       2-  chave primaria do registro alterado;

       3-  Tipo de alteração realizado (INSERT ou UPDATE ou DELETE);

       4-  Data e Hora da alteração.
*/
DELIMITER ;


    CREATE TABLE tabela_log_professor(
		cod_usuario VARCHAR(100),
        codProf INT,
        tipo_alteracao VARCHAR(6),
        dt_hora_alteracao DATETIME
	);
    ALTER TABLE tabela_log_professor
    ADD CONSTRAINT PK_tb_log_prof
		PRIMARY KEY(dt_hora_alteracao);
	
    ALTER TABLE tabela_log_professor
    ADD CONSTRAINT FK_tb_log_prof_tb_professor
		FOREIGN KEY(codProf) REFERENCES professor(codProf);

	DELIMITER $
    -- trigger para update
    CREATE TRIGGER tg_log_professor_atualizacao AFTER UPDATE
    ON professor
    FOR EACH ROW
    BEGIN
		
		DECLARE _cod_usuario VARCHAR(100);
		SET _cod_usuario = (SELECT CURRENT_USER());
		INSERT INTO tabela_log_professor(cod_usuario, codProf, tipo_alteracao, dt_hora_alteracao)
        VALUES(_cod_usuario, NEW.codProf, 'UPDATE', CURRENT_DATE());
    END$
    
    DELIMITER $
    -- trigger para insert
    CREATE TRIGGER tg_log_professor_insercao AFTER INSERT
    ON professor
    FOR EACH ROW
    BEGIN
		DECLARE _cod_usuario VARCHAR(100);
        SET _cod_usuario = (SELECT CURRENT_USER());
		INSERT INTO tabela_log_professor(cod_usuario, codProf, tipo_alteracao, dt_hora_alteracao)
        VALUES(_cod_usuario, NEW.codProf, 'INSERT', CURRENT_DATE());
    END$
    
	DELIMITER $
        -- trigger para delete
    CREATE TRIGGER tg_log_professor_insercao AFTER DELETE
    ON professor
    FOR EACH ROW
    BEGIN
		DECLARE _cod_usuario VARCHAR(100);
        SELECT CURRENT_USER() INTO _cod_usuario;
		INSERT INTO tabela_log_professor(cod_usuario, codProf, tipo_alteracao, dt_hora_alteracao)
        VALUES(_cod_usuario, OLD.codProf, 'DELETE', CURRENT_DATE());
    END$
    DELIMITER ;
    
    -- TAREFA 09
-- CRIAR PROCEDURE QUE:

-- Liste os códigos dos professores com título denominado 'Doutor' que não ministraram aulas em 2019/1. 
-- Caso nao existam professores dar uma mensagem de erro usando um dos métodos para o tratamento de Exceções.
DELIMITER $
CREATE PROCEDURE listar_codProf_Doutor_anoSem_dif_201901()
BEGIN
	DECLARE _codProf INT;
	DECLARE count INT DEFAULT 0;
    DECLARE final INT DEFAULT 0;
     
    DECLARE codProf_cursor CURSOR FOR		
		SELECT p.codProf FROM professor p 
		INNER JOIN titulacao tit ON p.codTit = tit.codTit
		INNER JOIN profturma proft ON proft.codProf = p.codProf
		INNER JOIN turma t ON  proft.anoSem = t.anoSem AND proft.codDepto = t.codDepto AND proft.numDisc = t.numDisc AND proft.siglaTur = t.siglaTur
		WHERE tit.nomeTit = 'Doutor'
		AND proft.anoSem <> '201901';
        
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET final = 1;    
    DECLARE EXIT HANDLER FOR SQLSTATE '45000' 
    BEGIN
		SELECT 'Não foi encontrado nenhum professor com titulo Doutor e que não tenha ministrado aula no ano semestre 201901' AS MensagemErro;
    END;

	CREATE TEMPORARY TABLE temp_cod(t_codProf INT);

	OPEN codProf_cursor;
    laco: LOOP
		FETCH codProf_cursor INTO _codProf;
        IF final = 1 THEN
			LEAVE laco;
		ELSE
			INSERT INTO temp_cod(t_codProf)
            VALUES(_codProf);
            SET count = count + 1;
		END IF;
	END LOOP;
    CLOSE codProf_cursor;
    -- verifica se pelo menos 1 registro foi encontrado
    IF count > 0 THEN
		SELECT t_codProf FROM temp_cod;
        DROP TEMPORARY TABLE temp_cod;
	ELSE
		DROP TEMPORARY TABLE temp_cod;
		SIGNAL SQLSTATE '45000';
	END IF;

END$
CALL listar_codProf_Doutor_anoSem_dif_201901();

-- 10 - Criar Trigger que: -- IMPEÇA A INCLUSAO DE PROFESSOR SEM TITULO DE DOUTORADO
-- Para impedir uma inserção deve ser sinalizado um erro com o SIGNAL
DELIMITER $
CREATE TRIGGER tg_impede_exclusao_prof_sem_tit_Doutorado BEFORE INSERT
ON professor
FOR EACH ROW
BEGIN
	DECLARE _codTit INT;
    
    SELECT codTit INTO _codTit FROM titulacao
    WHERE nomeTit = 'Doutorado';
    -- Busca o titulo do professor a ser deletado    
    IF NEW.codTit != _codTit THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é possivel inserir professores sem titulo de Doutorado';
    END IF;
END$

-- 12 - NATURAL E THETA JOIN
-- 1- Obter os nomes dos departamentos que têm turmas que, em 2023/1,
-- têm aulas na sala 203 do prédio denominado 'Informática - aulas'. 
-- Resolver usando theta-join e junção natural. 
SELECT dep.nomeDepto FROM depto dep, horario h, sala s, predio p
WHERE h.codDepto = dep.codDepto AND h.numSala = s.numSala AND s.codPred = p.codPred
AND h.anoSem = 20231 AND h.numSala = 203 AND p.nomePred = 'Informatica - aulas';

SELECT dep.nomeDepto FROM depto dep NATURAL JOIN horario h
NATURAL JOIN sala s NATURAL JOIN predio p
WHERE h.anoSem = 20231 AND h.numSala = 203 AND p.nomePred = 'Informatica - aulas';

-- 2- Obter o nome de cada departamento seguido do nome de cada uma de suas disciplinas que possui mais que três créditos 
-- (caso o departamento não tenha disciplinas ou caso o departamento não tenha disciplinas com mais que três créditos, seu nome deve aparecer seguido de vazio).

SELECT dep.nomeDepto, CASE
-- Dep tem disciplina com valor de credito > 3
WHEN (disc.creditoDisc > 3 AND disc.codDepto = dep.codDepto) THEN disc.nomeDisc
-- Dep tem disciplina mas ela não é maior que 3
WHEN(disc.creditoDisc < 3 AND disc.codDepto = dep.codDepto) THEN 'VAZIO'
-- Dep não tem disciplina
WHEN disc.nomeDisc IS NULL THEN 'VAZIO' END AS nomeDisciplina
FROM depto dep
-- Usa left outer join para incluir os valores NULL das relações, tenho em depto mas não em disciplina
LEFT OUTER JOIN disciplina disc ON disc.codDepto = dep.codDepto

/*
3- Para cada disciplina que possui pré-requisito, obter o nome da disciplina seguido do nome da disciplina que é seu pré-requisito 
(usar junções explícitas - quando possível usar junção natural). Resolver também usando Theta Join.
*/
-- JUNÇÃO EXPLICITA E NATURAL
select d1.nomeDisc AS 'Nome_Disciplina', d2.nomeDisc AS 'Nome_PreRequisito' 
-- D1 é a disciplina, sua chave vai estar em coDepto e numDisc de preReq
FROM disciplina d1 NATURAL JOIN preReq pr
-- D2 é a disciplina de pre requsito, vai estar em codDeptoPreReq e numDiscPreReq de preReq
INNER JOIN disciplina d2 ON pr.codDeptoPreReq = d2.codDepto AND pr.numDiscPreReq = d2.numDisc
WHERE d1.codDepto = pr.codDepto AND d1.numDisc = pr.numDisc AND
d1.numDisc != d2.numDisc;

-- THETA JOIN
select d1.nomeDisc AS 'Nome_Disciplina', d2.nomeDisc AS 'Nome_PreRequisito' 
-- D1 é a disciplina, sua chave vai estar em coDepto e numDisc de preReq
FROM disciplina d1, preReq pr, disciplina d2
-- D2 é a disciplina de pre requsito, vai estar em codDeptoPreReq e numDiscPreReq de preReq
WHERE pr.codDepto = d1.codDepto AND pr.numDisc = d1.numDisc AND
pr.codDeptoPreReq = d2.codDepto AND pr.numDiscPreReq = d2.numDisc AND
d1.codDepto = pr.codDepto AND d1.numDisc = pr.numDisc AND
d1.numDisc != d2.numDisc;

-- Inserção de dados
INSERT INTO depto (codDepto, nomeDepto) VALUES
('0001A', 'Ciencia da Computação'),
('0002A', 'Recursos Humanos'),
('0003A', 'Logistica'),
('INF01', 'Administração'),
('INF02', 'Informática');


INSERT INTO titulacao(CodTit, NomeTit) VALUES
(3, 'Doutorado');
(1, 'Mestre'),
(2, 'Doutor');


INSERT INTO professor (codProf, codDepto, codTit, nomeProf) VALUES
(7, 'INF01', 2, 'JHONhy');
(1, '0001A', 1, 'Geralt de Rivia'),
(2, 'INF01', 2, 'Yenneffer'),
(3, 'INF01', 2, 'Antunes'),
(4, 'INF01', 2, 'Jessica');

INSERT INTO predio (codPred, nomePred) VALUES
(3, 'Informática - aulas');

INSERT INTO sala (codPred, numSala, descricaoSala, capacSala) VALUES
(3, 203, 'Sala de informática', 40);

INSERT INTO disciplina (codDepto, numDisc, nomeDisc, creditoDisc) VALUES
('0001A', 1, 'LPEA', 100),
('0001A', 2, 'LP', 200),
('0002A', 1, 'CTB', 100),
('INF01', 1, 'GTE', 500),
('INF01', 3, 'ADM', 300),
('INF01', 4, 'SI', 300),
('INF02', 5, 'AMM', 50),
('INF02', 6, 'TESTE', 100),
('INF01', 6, 'GPP', 100),
('INF02', 9, 'INF', 2),
('INF01', 9, 'INF2', 500);



INSERT INTO preReq (codDeptoPreReq, numDiscPreReq, codDepto, numDisc) VALUES
('INF01', 3, 'INF01', 4),
('INF01', 3, 'INF02', 6),
('INF01', 4, 'INF02', 6);
INSERT INTO turma (anoSem, codDepto, numDisc, siglaTur, capacTur) VALUES
(20231,'INF02', 9, 'TI', 40),
(20231, 'INF01', 9, 'TX', 35);

INSERT INTO profTurma (anoSem, codDepto, numDisc, siglaTur, codProf) VALUES
(20231, 'INF02', 9, 'TI', 2),
(20231, 'INF01', 9, 'TX', 3);

INSERT INTO horario(anoSem, codDepto, numDisc, siglaTur, diaSem, horaInicio, numSala, codPred, numHoras) VALUES
(20231, 'INF02', 9, 'TI', 3, 1450, 203, 3, 4),
(20231, 'INF01', 9, 'TX', 2, 1900, 203, 3, 4);


