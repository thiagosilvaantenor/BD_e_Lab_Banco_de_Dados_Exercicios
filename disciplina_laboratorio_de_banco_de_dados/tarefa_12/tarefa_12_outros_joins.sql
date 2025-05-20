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
/*------------------------------------------------------------*/

-- Inserção de dados
INSERT INTO depto (codDepto, nomeDepto) VALUES
('0001A', 'Ciencia da Computação'),
('0002A', 'Recursos Humanos'),
('0003A', 'Logistica'),
('INF01', 'Administração'),
('INF02', 'Informática');


INSERT INTO disciplina (codDepto, numDisc, nomeDisc, creditoDisc) VALUES
('0001A', 1, 'LPEA', 100),
('0001A', 2, 'LP', 200),
('0002A', 1, 'CTB', 100),
('INF01', 1, 'GTE', 500),
('INF01', 3, 'ADM', 300),
('INF01', 4, 'SI', 300),
('INF02', 5, 'AMM', 50),
('INF02', 6, 'TESTE', 100),
('INF01', 6, 'GPP', 100);

INSERT INTO preReq (codDeptoPreReq, numDiscPreReq, codDepto, numDisc) VALUES
('INF01', 3, 'INF01', 4),
('INF01', 3, 'INF02', 6),
('INF01', 4, 'INF02', 6);

INSERT INTO turma (anoSem, codDepto, numDisc, siglaTur, capacTur) VALUES
(20241,'0001A', 1, 'TA', 40),
(20242, '0001A', 1, 'TB', 40),
(20021, 'INF01', 3, 'TN', 30),
(20021, 'INF01', 4, 'TN', 30),
(20021, 'INF02', 5, 'TC', 30),
(20022, 'INF01', 1, 'TA', 30),
(20021, 'INF02', 6, 'TA', 30),
(20021, 'INF01', 6, 'TX', 30),
(20021, 'INF02', 6, 'TN', 30);

INSERT INTO titulacao(CodTit, NomeTit) VALUES
(1, 'Mestre'),
(2, 'Doutor');

INSERT INTO professor (codProf, codDepto, codTit, nomeProf) VALUES
(1, '0001A', 1, 'Geralt de Rivia'),
(2, 'INF01', 2, 'Yenneffer'),
(3, 'INF01', 2, 'Antunes'),
(4, 'INF01', 2, 'Jessica');

INSERT INTO profTurma (anoSem, codDepto, numDisc, siglaTur, codProf) VALUES
(20021, 'INF01', 3, 'TN', 2),
(20021, 'INF01', 4, 'TN', 3),
(20021, 'INF02', 5, 'TC', 4),
(20022, 'INF01', 1, 'TA', 4),
(20021, 'INF02', 6, 'TA', 3),
(20021, 'INF02', 6, 'TN', 3),
(20021, 'INF01', 6, 'TX', 2);

INSERT INTO predio (codPred, nomePred) VALUES
(1, 'Principal'),
(43423, 'Laboratorios');

INSERT INTO sala (codPred, numSala, descricaoSala, capacSala) VALUES
(1, 12, 'sala de aula padrão', 40),
(1, 22, 'sala de aula padrão', 35),
(43423, 101, 'lab com notebooks',35);

INSERT INTO horario(anoSem, codDepto, numDisc, siglaTur, diaSem, horaInicio, numSala, codPred, numHoras) VALUES
(20022, 'INF01', 1, 'TA', 2, 1450, 22, 1, 4),
(20021, 'INF01', 3, 'TN', 3, 1900, 12, 1, 4),
(20021, 'INF01', 4, 'TN', 4, 1900, 12, 1, 4),
(20021, 'INF02', 5, 'TC', 2, 1900, 22, 1, 2),
(20021, 'INF02', 6, 'TA', 2, 0800, 12, 1, 2),
(20021, 'INF02', 6, 'TN', 6, 1900, 101, 43423, 4),
(20021, 'INF01', 6, 'TX', 3, 1900, 12, 1, 4);

/*
1- Obter os nomes dos departamentos que têm turmas que, em 2023/1, 
têm aulas na sala 203 do prédio denominado 'Informática - aulas'. Resolver usando theta-join e junção natural.
*/

/*Inserts para testar*/
INSERT INTO predio (codPred, nomePred) VALUES
(3, 'Informática - aulas');

INSERT INTO sala (codPred, numSala, descricaoSala, capacSala) VALUES
(3, 203, 'Sala de informática', 40);

INSERT INTO disciplina (codDepto, numDisc, nomeDisc, creditoDisc) VALUES
('INF02', 9, 'INF', 2),
('INF01', 9, 'INF2', 500);
INSERT INTO turma (anoSem, codDepto, numDisc, siglaTur, capacTur) VALUES
(20231,'INF02', 9, 'TI', 40),
(20231, 'INF01', 9, 'TX', 35);

INSERT INTO profTurma (anoSem, codDepto, numDisc, siglaTur, codProf) VALUES
(20231, 'INF02', 9, 'TI', 2),
(20231, 'INF01', 9, 'TX', 3);

INSERT INTO horario(anoSem, codDepto, numDisc, siglaTur, diaSem, horaInicio, numSala, codPred, numHoras) VALUES
(20231, 'INF02', 9, 'TI', 3, 1450, 203, 3, 4),
(20231, 'INF01', 9, 'TX', 2, 1900, 203, 3, 4);
-- Usando ThetaJoin
SELECT dp.nomeDepto FROM depto dp, horario h, sala s, predio p
WHERE dp.codDepto = h.codDepto AND
p.codPred = h.codPred AND
s.codPred = p.codPred AND
s.numSala = h.numSala AND
h.anoSem = 20231 AND
s.numSala =  203 AND 
p.nomePred = 'Informática - aulas';

-- Usando Natural Join
SELECT dp.nomeDepto FROM depto dp NATURAL JOIN horario h, sala s, predio p
WHERE h.anoSem = 20231 AND
s.numSala =  203 AND 
p.nomePred = 'Informática - aulas';

/* 
2- Obter o nome de cada departamento seguido do nome de cada uma de suas disciplinas que possui mais 
que três créditos (caso o departamento não tenha disciplinas ou caso o departamento não tenha disciplinas 
com mais que três créditos, seu nome deve aparecer seguido de vazio) 
*/
-- depto sem disciplina:
INSERT INTO depto(codDepto, nomeDepto) values
('INF03', 'Cyberseguranca');

SELECT dp.nomeDepto, CASE 
WHEN (disc.creditoDisc > 3 AND disc.codDepto = dp.codDepto) THEN disc.nomeDisc 
WHEN (disc.creditoDisc < 3 AND disc.codDepto = dp.codDepto) THEN 'VAZIO'
WHEN disc.nomeDisc IS NULL THEN 'VAZIO' END AS nomeDisciplina
FROM depto dp
LEFT JOIN disciplina disc ON dp.codDepto = disc.codDepto
ORDER BY disc.nomeDisc

/*
3- Para cada disciplina que possui pré-requisito, obter o nome da disciplina seguido do nome da disciplina que é seu pré-requisito 
(usar junções explícitas - quando possível usar junção natural). Resolver também usando Theta Join.
*/
-- Usando Theta Join
SELECT disc1.nomeDisc AS 'Nome_Disciplina', disc2.nomeDisc AS 'Nome_PreRequisito'
FROM disciplina disc1, prereq pr, disciplina disc2 
WHERE disc1.codDepto = pr.codDepto AND
disc1.numDisc = pr.numDisc AND
disc2.codDepto = pr.codDeptoPreReq AND
disc2.numDisc = pr.numDiscPreReq AND
-- Garante que são disciplinas distintas (ADM != SI)
disc1.numDisc != disc2.numDisc;

-- Usando NATURAL JOIN e INNER JOIN quando necessário
SELECT disc1.nomeDisc AS 'Nome_Disciplina', disc2.nomeDisc AS 'Nome_PreRequisito'
FROM disciplina disc1 NATURAL JOIN prereq pr
INNER JOIN disciplina disc2 ON disc2.codDepto = pr.codDeptoPreReq AND
disc2.numDisc = pr.numDiscPreReq
WHERE disc1.codDepto = pr.codDepto 
		AND disc1.numDisc = pr.numDisc
		-- Garante que são disciplinas distintas (ADM != SI)
		AND disc1.numDisc != disc2.numDisc;