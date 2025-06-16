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
BEGIN TRAN
	DELIMITER $
    CREATE PROCEDURE pr_obter_nomeProf_com_codProf(IN _CodProf INT, OUT _nomeProf VARCHAR(40))
    BEGIN
		DECLARE EXIT HANDLER FOR NOT FOUND
        BEGIN
			SELECT 'Nenhum professor com este CodProf foi não encontrado' AS mensagemErro;
        END;
        SELECT nomeProf INTO _nomeProf from professor WHERE professor.codProf = _CodProf;
    END$
COMMIT;

CALL pr_obter_nomeProf_com_codProf(5, @_nomeProf);