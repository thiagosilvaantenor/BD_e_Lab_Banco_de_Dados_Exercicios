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
    numHora		INT
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
ADD CONSTRAINT PK_TB_depto
PRIMARY KEY (codDepto);

-- titulacao
ALTER TABLE titulacao
ADD CONSTRAINT PK_TB_titulacao
PRIMARY KEY (codTit);

-- Professor
ALTER TABLE professor
ADD CONSTRAINT PK_TB_professor
PRIMARY KEY(codProf);

ALTER TABLE professor
ADD CONSTRAINT FK_TB_professor_TB_titulacao
FOREIGN KEY(codTit) REFERENCES titulacao(codTit);

ALTER TABLE professor
ADD CONSTRAINT FK_TB_professor_TB_depto
FOREIGN KEY(codDepto) REFERENCES depto(codDepto);

-- Disciplina
ALTER TABLE disciplina
ADD CONSTRAINT PK_tb_disciplina
PRIMARY KEY(codDepto, numDisc);

ALTER TABLE disciplina
ADD CONSTRAINT FK_TB_disciplina_TB_depto
FOREIGN KEY(codDepto) REFERENCES depto(codDepto);

-- PreReq
ALTER TABLE PreReq
ADD CONSTRAINT PK_TB_preReq
PRIMARY KEY(codDeptoPreReq, numDiscPreReq, codDepto, NumDisc);

ALTER TABLE PreReq
ADD CONSTRAINT FK_TB_preReq_TB_Disciplina
FOREIGN KEY(codDepto, numDisc) 
REFERENCES Disciplina(codDepto, NumDisc);

ALTER TABLE PreReq
ADD CONSTRAINT FK_TB_preReq_Tem_Disciplina
FOREIGN KEY(codDeptoPreReq, numDiscPreReq) 
REFERENCES Disciplina(codDepto, NumDisc);

-- Turma
ALTER TABLE turma
ADD CONSTRAINT PK_TB_Turma
PRIMARY KEY(anoSem, CodDepto, NumDisc, SiglaTur);

ALTER TABLE turma
ADD CONSTRAINT FK_TB_turma_TB_Disciplina
FOREIGN KEY(codDepto, NumDisc) REFERENCES Disciplina(codDepto, NumDisc);

-- ProfTurma
ALTER TABLE profTurma
ADD CONSTRAINT PK_TB_profTurma
PRIMARY KEY(anoSem, codDepto, numDisc, siglaTur, codProf);

ALTER TABLE profTurma
ADD CONSTRAINT FK_TB_profTurma_TB_professor
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
/* -------------------- */

/*
Criar trigger para registrar um LOG das atualizações das Tabela Professor.
No Log deve existir:
           1-  código do usuário que fez a alteração;
           2-  chave primaria do registro alterado;
           3-  Tipo de alteração realizado (INSERT ou UPDATE ou DELETE);
           4-  Data e Hora da alteração.
Entregar a estrutura da Tabela de LOG ( pode ser chamada Tabela_Log_Professor ) ;
e o Código da(s) Trigger(s).

-- para selecionar o usuario corrente no mysql
SELECT CURRENT_USER();
*/
SELECT CURRENT_USER();
CREATE TABLE tabela_Log_Professor(
codUser VARCHAR(100),
codProf INT,
tipoAlteracao VARCHAR(6),
dataHoraAlteracao TIMESTAMP 
);
ALTER TABLE tabela_Log_Professor
ADD PRIMARY KEY(dataHoraAlteracao);


-- TRIGGER PARA INSERT
DELIMITER $
CREATE TRIGGER tg_log_INSERT_professor
AFTER INSERT
ON professor
FOR EACH ROW
BEGIN
	DECLARE usuario VARCHAR(100);
    SET usuario = (SELECT CURRENT_USER());
    INSERT INTO tabela_log_professor(codUser, codProf, tipoAlteracao, dataHoraAlteracao)
    VALUES (usuario, NEW.codProf, 'INSERT', now());
END
$

-- TRIGGER PARA UPDATE
DELIMITER $
CREATE TRIGGER tg_log_UPDATE_professor
AFTER UPDATE
ON professor
FOR EACH ROW
BEGIN
	DECLARE usuario VARCHAR(100);
    SET usuario = (SELECT CURRENT_USER());
    INSERT INTO tabela_log_professor(codUser, codProf, tipoAlteracao, dataHoraAlteracao)
    VALUES (usuario, OLD.codProf, 'UPDATE', now());
END
$

-- TRIGGER PARA DELETE
DELIMITER $
CREATE TRIGGER tg_log_DELETE_professor
AFTER DELETE
ON professor
FOR EACH ROW
BEGIN
	DECLARE usuario VARCHAR(100);
    SET usuario = (SELECT CURRENT_USER());
    INSERT INTO tabela_log_professor(codUser, codProf, tipoAlteracao, dataHoraAlteracao)
    VALUES (usuario, OLD.codProf, 'DELETE', now());
END
$

-- DADOS PARA TESTE
INSERT INTO titulacao(CodTit, NomeTit) VALUES
(1, 'Mestre'),
(2, 'Doutor');

INSERT INTO depto (codDepto, nomeDepto) VALUES
('0001A', 'Ciencia da Computação'),
('0002A', 'Recursos Humanos'),
('0003A', 'Logistica'),
('INF01', 'Administração'),
('INF02', 'Informática');
-- INSERT professor
INSERT INTO professor (codProf, codDepto, codTit, nomeProf) VALUES
(2, 'INF01', 2, 'Yenneffer')
-- UPDATE professor
UPDATE professor SET nomeProf = 'Geralt'
WHERE codProf = 2
-- DELETE professor
DELETE FROM professor WHERE codProf = 2

-- Select para testar se foi salvo os logs
select * from tabela_log_professor