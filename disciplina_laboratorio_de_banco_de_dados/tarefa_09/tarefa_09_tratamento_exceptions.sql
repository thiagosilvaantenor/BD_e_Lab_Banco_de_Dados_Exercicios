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
-- CRIAR PROCEDURE QUE:

-- Liste os códigos dos professores com título denominado 'Doutor' 
que não ministraram aulas em 2019/1.
-- Caso nao existam professores dar uma mensagem de erro 
usando um dos métodos para o tratamento de Exceções.
*/
DELIMITER $$
-- DROP procedure listar_codProf_titulo_Doutor
CREATE PROCEDURE listar_codProf_titulo_Doutor()
BEGIN
		DECLARE count INT DEFAULT 0;
        DECLARE _codProf INT;
        DECLARE final INT DEFAULT FALSE;
                
		DECLARE codCursor CURSOR FOR 
			-- EXIBE o codProf 
			SELECT p.codProf FROM professor p
			INNER JOIN titulacao t ON p.codTit = t.codTit
			INNER JOIN profTurma prt ON prt.codProf = p.codProf
			WHERE t.nomeTit = 'Doutor' AND
			prt.anoSem != '20191';
		
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET final = TRUE;
        
		  DECLARE EXIT HANDLER FOR SQLEXCEPTION
			BEGIN
				-- Verifica se nenhum registro foi encontrado
				IF count = 0 THEN
					SELECT 'Nenhum registro encontrado' AS Mensagem_Erro;
				END IF;
			END;
			CREATE TEMPORARY TABLE tb_codProf (t_codProf INT);
        
        
        OPEN codCursor;
        laco_leitura: LOOP
			FETCH codCursor INTO _codProf;
			if final = TRUE THEN
				leave laco_leitura;
			ELSE
				INSERT INTO tb_codProf (t_codProf) VALUES (_codProf);
                SET count = count + 1;
			END IF;
		END LOOP;
        
         -- Verifica se a tabela temporária contém registros
		IF count > 0 THEN
        -- Caso contrário, retornar os códigos encontrados
			SELECT t_codProf FROM tb_codProf;
		ELSE 
			SELECT 'Nenhum registro encontrado' AS Mensagem_Erro;
        END IF;

		
        DROP TEMPORARY TABLE tb_codProf;
        CLOSE codCursor;

END$$
DELIMITER ;
call listar_codProf_titulo_Doutor();