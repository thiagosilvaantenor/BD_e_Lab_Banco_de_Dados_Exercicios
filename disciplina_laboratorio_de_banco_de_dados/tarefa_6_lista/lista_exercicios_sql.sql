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
('INF01', 3, 'INF01', 4);


INSERT INTO turma (anoSem, codDepto, numDisc, siglaTur, capacTur) VALUES
(20241,'0001A', 1, 'TA', 40),
(20242, '0001A', 1, 'TB', 40),
(20021, 'INF01', 3, 'TN', 30),
(20021, 'INF01', 4, 'TN', 30),
(20021, 'INF02', 5, 'TC', 30),
(20022, 'INF01', 1, 'TA', 30),
(20021, 'INF02', 6, 'TA', 30),
(20021, 'INF02', 6, 'TA', 30),
(20021, 'INF01', 6, 'TX', 30);

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
-- Lista de Exercícios, fazer em stored procedures com cursor
-- 1. Obter os códigos dos diferentes departamentos que tem turmas no ano-semestre 2002/1  

DELIMITER //
CREATE PROCEDURE obter_cod_depto_tem_turma_2002_01()
BEGIN
	-- variaveis
    DECLARE cod CHAR(05);
    DECLARE final boolean DEFAULT FALSE;
	-- declarando cursor
    DECLARE codDepto_cursor CURSOR FOR 
		SELECT distinct dp.codDepto FROM depto dp
		INNER JOIN disciplina disc
		ON dp.codDepto = disc.codDepto
		INNER JOIN turma t
		ON disc.NumDisc = t.NumDisc
		WHERE t.anoSem = 20021;
        
	-- função para lidar com o NOT FOUND
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET final = TRUE;
    
	-- Executa o CURSOR
    OPEN codDepto_cursor;
    
    -- Loop com fetch de cada resultado
    read_loop: LOOP
		FETCH codDepto_cursor INTO cod;
        IF final THEN
			LEAVE read_loop;
		END IF;
	-- cria uma tabela temporaria para colocar os dados e depois ler eles
		CREATE TEMPORARY TABLE IF NOT EXISTS tb_cod( codDepto CHAR(05));
		INSERT INTO tb_cod (codDepto) VALUES (cod);
	END LOOP;
    -- Exibe o resultado do cursor na tabela temporaria;
    SELECT codDepto FROM tb_cod;
    
    -- Exclui a tabela temporaria
    DROP TEMPORARY TABLE tb_cod;
    -- fecha o cursor
	CLOSE codDepto_cursor;
END//

DELIMITER ;
CALL obter_cod_depto_tem_turma_2002_01();

-- 2. Obter os códigos dos professores que são do departamento de código 'INF01' e que ministraram ao menos uma turma em 2002/1. 
DELIMITER //
CREATE PROCEDURE codProf_Depto_INF01_AnoSem_20021()
BEGIN

	DECLARE cod INT;
    DECLARE final BOOLEAN DEFAULT FALSE;
    
    DECLARE codProf_cursor CURSOR FOR
		SELECT codProf from profturma profT
		where profT.codDepto = 'INF01' AND profT.anoSem = 20021;
	
    -- função para lidar com o NOT FOUND
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET final = TRUE;
    
	-- Executa o CURSOR
    OPEN codProf_cursor;
    
    read_loop: LOOP
		FETCH codProf_cursor INTO cod;
        IF final THEN
			LEAVE read_loop;
		END IF;
		-- cria uma tabela temporaria para colocar os dados e depois ler eles
		CREATE TEMPORARY TABLE IF NOT EXISTS tb_cod( codProf INT);
		INSERT INTO tb_cod (codProf) VALUES (cod);
	END LOOP;
    
    SELECT codProf FROM tb_cod;
    
    DROP TEMPORARY TABLE tb_cod;
    
    CLOSE codProf_cursor; 
END//
DELIMITER ;

CALL codProf_Depto_INF01_AnoSem_20021();

-- 3. Obter os horários de aula (dia da semana,hora inicial e número de horas ministradas) do professor "Antunes" em 20021.
DELIMITER //
CREATE PROCEDURE obter_horarios_prof_antunes_2002_1()
	BEGIN
		DECLARE diaSem INT;
        DECLARE horaInicio INT;
        DECLARE numHoras INT;
        DECLARE final BOOLEAN DEFAULT FALSE;
        
        DECLARE horario_cursor CURSOR FOR
			SELECT h.diaSem, h.horaInicio, h.numHoras from horario h
			INNER JOIN turma t
			ON h.anoSem = t.anoSem AND h.codDepto = t.codDepto AND h.numDisc = t.numDisc AND h.siglaTur = t.siglaTur
			INNER JOIN profTurma profT
			ON profT.anoSem = t.anoSem AND profT.codDepto = t.codDepto AND profT.numDisc = t.numDisc AND profT.siglaTur = t.siglaTur
			INNER JOIN professor prof
			ON profT.codProf = prof.codProf
			WHERE prof.nomeProf = 'Antunes' AND h.anoSem = 20021;
            
		    -- função para lidar com o NOT FOUND
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET final = TRUE;
        
        OPEN horario_cursor;
        
        laco_de_leitura: LOOP
			FETCH horario_cursor INTO diaSem, horaInicio, numHoras;
            IF final THEN
				LEAVE laco_de_leitura;
			END IF;
            
            CREATE TEMPORARY TABLE IF NOT EXISTS tb_horario(t_diaSem INT, t_horaInicio INT, t_numHoras INT);
            INSERT INTO tb_horario(t_diaSem, t_horaInicio, t_numHoras) VALUES(diaSem, horaInicio, numHoras);
		END LOOP;
        
        SELECT diaSem, horaInicio, numHoras FROM tb_horario;
        
        DROP TEMPORARY TABLE tb_horario;
        CLOSE horario_cursor;
	END//
    DELIMITER ;
    
    CALL obter_horarios_prof_antunes_2002_1();
	
-- 4.Obter os códigos dos professores com título denominado 'Doutor' que não ministraram aulas em 2002/1.
DELIMITER //
CREATE PROCEDURE obter_codProf_com_titulacao_doutor_e_anoSem_diferente_20021()
	BEGIN
		DECLARE final BOOLEAN DEFAULT FALSE;
        DECLARE cod INT;
        
        DECLARE codProfCursor CURSOR FOR
			SELECT prof.codProf FROM professor prof
			INNER JOIN titulacao t ON prof.codTit = t.codTit
			INNER JOIN profTurma profT ON profT.codProf = prof.codProf
			WHERE t.nomeTit = 'Doutor' AND profT.anoSem != 20021;
		

    -- função para lidar com o NOT FOUND
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET final = TRUE;
		
        -- cria tabela temporaria para exibição dos dados
        CREATE TEMPORARY TABLE tb_prof(t_codProf INT);
        
        OPEN codProfCursor;
        
		laco_leitura: LOOP
			FETCH codProfCursor INTO cod;
            IF final THEN
				LEAVE laco_leitura;
			END IF;
            INSERT INTO tb_prof (t_codProf) VALUES (cod);
		END LOOP;
        
        SELECT t_codProf FROM tb_prof;
        DROP TEMPORARY TABLE t_codProf;
        CLOSE codProfCursor;
END//
DELIMITER ;
CALL obter_codProf_com_titulacao_doutor_e_anoSem_diferente_20021();

/* 5.Obter os identificadores das salas (código do prédio e número da sala) que, em 2002/1: nas segundas-feiras (dia da semana = 2), tiveram ao menos uma turma 
do departamento 'Informática', e nas quartas-feiras (dia da semana = 4), tiveram ao menos uma turma ministrada pelo professor denominado 'Antunes'. */
DELIMITER //
CREATE PROCEDURE obter_salas_20021_2_Informatica_e_4_Antunes()
	BEGIN
		DECLARE cod INT;
        DECLARE numS INT;
        DECLARE final BOOLEAN DEFAULT FALSE;
        
        DECLARE salasCursor CURSOR FOR
			SELECT DISTINCT s.codPred, s.numSala FROM sala s
			INNER JOIN horario h ON h.codPred = s.codPred AND h.numSala = s.numSala
			INNER JOIN turma t ON h.anoSem = t.anoSem 
					AND h.codDepto = t.codDepto 
					AND h.numDisc = t.numDisc 
					AND h.siglaTur = t.siglaTur
			INNER JOIN disciplina dp ON t.codDepto = dp.codDepto AND t.numDisc = dp.numDisc
			INNER JOIN depto dep ON dp.codDepto = dep.codDepto
			WHERE h.anoSem = 20021 
			AND h.diaSem = 2 
			AND dep.nomeDepto = 'Informática' 
			AND EXISTS (
			SELECT 1
			FROM horario h2
			INNER JOIN turma t2 ON h2.anoSem = t2.anoSem 
						 AND h2.codDepto = t2.codDepto 
						 AND h2.numDisc = t2.numDisc 
						 AND h2.siglaTur = t2.siglaTur
						 INNER JOIN profTurma profT ON t2.anoSem = profT.anoSem 
							 AND t2.codDepto = profT.codDepto 
							 AND t2.numDisc = profT.numDisc 
							 AND t2.siglaTur = profT.siglaTur
			INNER JOIN professor p ON profT.codProf = p.codProf
			WHERE h2.anoSem = 20021
			  AND h2.diaSem = 4
			  AND h2.codPred = h.codPred
			  AND h2.numSala = h.numSala
			  AND p.nomeProf = 'Antunes'
			);
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET final = TRUE;
        
        CREATE TEMPORARY TABLE tb_salas (t_codPred INT, t_numSala INT);
        
        OPEN salasCursor;
        
        laco_leitura:LOOP
			FETCH salasCursor INTO cod, numS;
			IF (final = TRUE) THEN
				LEAVE laco_leitura;
			END IF;
            
            INSERT INTO tb_salas(t_codPred, t_numSala) VALUES (cod, numS);
		END LOOP;
        
        SELECT t_codPred, t_numSala FROM tb_salas;
		
        DROP TEMPORARY TABLE tb_salas;
        
        CLOSE salasCursor;
END//
DELIMITER ;
CALL obter_salas_20021_2_Informatica_e_4_Antunes();

-- 6.Obter o dia da semana, a hora de início e o número de horas de cada horário de cada turma ministrada por um professor de nome `Antunes', em 2002/1, na sala número 101 do prédio de código 43423.
DELIMITER //
CREATE PROCEDURE obter_horario_antunes_20021_101_43422()
	BEGIN
		DECLARE _diaSem INT;
        DECLARE _horaInicio INT;
        DECLARE _numHoras INT;
        DECLARE final BOOLEAN DEFAULT FALSE;
        
        DECLARE horarioCursor CURSOR FOR
		SELECT h.diaSem, h.horaInicio, h.numHoras FROM horario h
		INNER JOIN turma t ON h.anoSem = t.anoSem 
							AND h.codDepto = t.codDepto 
							AND h.numDisc = t.numDisc 
							AND h.siglaTur = t.siglaTur
		INNER JOIN profTurma profT ON t.anoSem = profT.anoSem 
									 AND t.codDepto = profT.codDepto 
									 AND t.numDisc = profT.numDisc 
									 AND t.siglaTur = profT.siglaTur
					INNER JOIN professor p ON profT.codProf = p.codProf
		WHERE p.nomeProf = 'Antunes' 
			AND h.anoSem = 20021
			AND h.numSala = 101
			AND h.codPred = 43423;
	
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET final = TRUE;
    
    CREATE TEMPORARY TABLE tb_horario (t_diaSem INT, t_horaInicio INT, t_numHoras INT);
    
    OPEN horarioCursor;
    laco_leitura: LOOP
		FETCH horarioCursor INTO _diaSem, _horaInicio, _numHoras;
        IF (final = TRUE) THEN
			LEAVE laco_leitura;
		END IF;
        INSERT INTO tb_horario (t_diaSem, t_horaInicio, t_numHoras) VALUES (_diaSem, _horaInicio, _numHoras);
	END LOOP;
	
    SELECT t_diaSem, t_horaInicio, t_numHoras FROM tb_horario;
    DROP TEMPORARY TABLE tb_horario;
    CLOSE horarioCursor;
END//
DELIMITER ;
CALL obter_salas_20021_2_Informatica_e_4_Antunes();

/* 7.Um professor pode ministrar turmas de disciplinas pertencentes a outros departamentos. Para cada professor que já ministrou aulas em disciplinas de outros departamentos
, obter o código do professor, seu nome, o nome de seu departamento e o nome do departamento no qual ministrou disciplina */
DELIMITER //
CREATE PROCEDURE obter_codDepto_prof_dif_codDepto_disc()
	BEGIN
		DECLARE _codProf INT;
        DECLARE _nomeProf VARCHAR(40);
        DECLARE _codDepto CHAR(5);
        DECLARE _codDeptoDisc CHAR(5);
        DECLARE final BOOLEAN DEFAULT FALSE;
        
        DECLARE codCursor CURSOR FOR
			SELECT p.codProf, p.nomeProf, p.codDepto, profT.codDepto AS deptoDisciplina FROM professor p
			INNER JOIN profTurma profT ON profT.codProf = p.codProf
			WHERE p.codDepto != profT.codDepto
            GROUP BY p.codProf, p.nomeProf, p.codDepto, profT.codDepto;
		
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET final = TRUE;
        
        CREATE TEMPORARY TABLE tb_cods(t_codProf INT, t_nomeProf VARCHAR(40), t_codDepto CHAR(5), t_codDeptoDisc CHAR(5));
        OPEN codCursor;
        laco_leitura: LOOP
			FETCH codCursor INTO _codProf, _nomeProf, _codDepto, _codDeptoDisc;
            IF (final = TRUE)THEN
				LEAVE laco_leitura;
			END IF;
            INSERT INTO tb_cods (t_codProf, t_nomeProf, t_codDepto, t_codDeptoDisc) VALUES (_codProf, _nomeProf, _codDepto, _codDeptoDisc);
		END LOOP;
        
        SELECT t_codProf, t_nomeProf, t_codDepto, t_codDeptoDisc FROM tb_cods;
        DROP TEMPORARY TABLE tb_cods;
        CLOSE codCursor;
END//
DELIMITER ;
CALL obter_codDepto_prof_dif_codDepto_disc();

/* 8.Obter o nome dos professores que possuem horários conflitantes
(possuem turmas que tenham a mesma hora inicial, no mesmo dia da semana e no mesmo semestre). Além dos nomes, mostrar as chaves primárias das turmas em conflito.
 */
DELIMITER //
CREATE PROCEDURE obter_nomeProf_disciplina_horario_conflitante()
	BEGIN
		DECLARE _nomeProf VARCHAR(40);
		DECLARE _anoSem1 INT;
		DECLARE _codDepto1 CHAR(5);
		DECLARE _numDisc1 INT;
		DECLARE _siglaTur1 CHAR(2);
        DECLARE _anoSem2 INT;
		DECLARE _codDepto2 CHAR(5);
        DECLARE _numDisc2 INT;
		DECLARE _siglaTur2 CHAR(2);
        DECLARE final BOOLEAN DEFAULT FALSE;
        
        DECLARE conflitCursor CURSOR FOR
			SELECT p.nomeProf,
			-- T1
			profT1.anoSem AS anoSem1,
			profT1.codDepto AS codDepto1,
			profT1.numDisc AS numDisc1,
			profT1.siglaTur AS siglaTur1,
			-- T2
			profT2.anoSem AS anoSem2,
			profT2.codDepto AS codDepto2,
			profT2.numDisc AS numDisc2,
			profT2.siglaTur AS siglaTur2
			 
			FROM profTurma profT1
			INNER JOIN horario h1 ON profT1.anoSem = h1.anoSem 
								AND profT1.codDepto = h1.codDepto 
								AND profT1.numDisc = h1.numDisc 
								AND profT1.siglaTur = h1.siglaTur
			INNER JOIN profTurma profT2 ON profT1.codProf = profT2.codProf
			INNER JOIN horario h2 ON profT2.anoSem = h2.anoSem 
								AND profT2.codDepto = h2.codDepto 
								AND profT2.numDisc = h2.numDisc 
								AND profT2.siglaTur = h2.siglaTur
			INNER JOIN professor p ON profT1.codProf = p.codProf
			WHERE 
				-- Filtra o horario das turmas conflitantes
				h1.anoSem = h2.anoSem AND
				h1.diaSem = h2.diaSem AND
				h1.horaInicio = h2.horaInicio
				
				-- Garante que são turmas diferentes
				AND (
					profT1.codDepto != profT2.codDepto OR
					profT1.numDisc != profT2.numDisc OR
					profT1.siglaTur != profT2.siglaTur
				)
				-- Elimina repetições espelhadas
				AND (
					CONCAT(profT1.codDepto, profT1.numDisc,  profT1.siglaTur) <
					CONCAT(profT2.codDepto, profT2.numDisc,  profT2.siglaTur)
				);
    
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET final = TRUE;
    CREATE TEMPORARY TABLE tb_conflit( t_nomeProf VARCHAR(40),
    t_anoSem1 INT, t_codDepto1 CHAR(5), t_numDisc1 INT , t_siglaTur1 CHAR(2),
    t_anoSem2 INT, t_codDepto2 CHAR(5), t_numDisc2 INT , t_siglaTur2 CHAR(2));
    
    OPEN conflitCursor;
    laco_leitura: LOOP
		FETCH conflitCursor INTO _nomeProf, _anoSem1, _codDepto1,  _numDisc1, _siglaTur1, _anoSem2, _codDepto2, _numDisc2, _siglaTur2;
        IF (final = TRUE) THEN
			LEAVE laco_leitura;
		END IF;
        
		INSERT INTO tb_conflit(t_nomeProf, t_anoSem1, t_codDepto1, t_numDisc1, t_siglaTur1,
		t_anoSem2, t_codDepto2, t_numDisc2, t_siglaTur2) VALUES(_nomeProf, _anoSem1, _codDepto1, _numDisc1, _siglaTur1,
		_anoSem2, _codDepto2, _numDisc2, _siglaTur2);
	END LOOP;
		
	SELECT t_nomeProf, t_anoSem1, t_codDepto1, t_numDisc1, t_siglaTur1, t_anoSem2, t_codDepto2, t_numDisc2, t_siglaTur2
    FROM tb_conflit;
    
	DROP TEMPORARY TABLE tb_conflit;
    CLOSE conflitCursor;
END//
DELIMITER ;
CALL obter_nomeProf_disciplina_horario_conflitante();


-- 9.Para cada disciplina que possui pré-requisito, obter o nome da disciplina seguido do nome da disciplina que é seu pré-requisito.
DELIMITER //
CREATE PROCEDURE obter_nomeDisc_nomDiscPreReq()
	BEGIN
		DECLARE final BOOLEAN DEFAULT FALSE;
        DECLARE _nomeDisc VARCHAR(10);
        DECLARE _nomeDiscPreReq VARCHAR(10);
        
        DECLARE nomeDiscCursor CURSOR FOR
			SELECT d1.nomeDisc, d2.nomeDisc AS nomeDiscPreReq FROM disciplina d1
			-- D1
			INNER JOIN preReq pr1 ON pr1.codDepto = d1.codDepto
								  AND pr1.numDisc = d1.numDisc
			-- D2
			INNER JOIN disciplina d2 ON pr1.codDeptoPreReq = d2.codDepto
									AND pr1.numDiscPreReq = d2.numDisc
			WHERE 
			-- TEM PRE REQ? 
			d1.codDepto = pr1.codDepto 
			AND d1.numDisc = pr1.numDisc
			-- GARANTE QUE SÃO Disciplinas distintas
			AND d1.numDisc != d2.numDisc;
		
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET final = TRUE;
        CREATE TEMPORARY TABLE tb_preReq(t_nomeDisc VARCHAR(10), t_nomeDiscPreReq VARCHAR(10));
        OPEN nomeDiscCursor;
        
        laco_leitura : LOOP
			FETCH nomeDiscCursor INTO _nomeDisc, _nomeDiscPreReq;
            IF(final = TRUE)THEN
				LEAVE laco_leitura;
			END IF;
            INSERT INTO tb_preReq( t_nomeDisc, t_nomeDiscPreReq) VALUES (_nomeDisc, _nomeDiscPreReq);
		END LOOP;
        CLOSE nomeDiscCursor;
        SELECT t_nomeDisc, t_nomeDiscPreReq FROM tb_preReq;
        DROP TEMPORARY TABLE tb_preReq;
END//
DELIMITER ;
CALL obter_nomeDisc_nomDiscPreReq();

-- 10.Obter os nomes das disciplinas que não têm pré-requisito.  
DELIMITER //
CREATE PROCEDURE obter_nomeDisc_sem_preReq()
	BEGIN
		DECLARE final BOOLEAN DEFAULT FALSE;
        DECLARE _nomeDisc VARCHAR(10);
        
        DECLARE semPreReqCursor CURSOR FOR
			SELECT d.nomeDisc FROM disciplina d
						LEFT OUTER JOIN preReq pr 
						ON pr.codDepto = d.codDepto AND pr.numDisc = d.numDisc
						WHERE 
						-- NÃO TEM PRE REQ
						pr.codDepto IS NULL AND pr.numDisc IS NULL;
		
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET final = TRUE;
        CREATE TEMPORARY TABLE tb_semPreReq(t_nomeDisc VARCHAR(10));
        OPEN semPreReqCursor;
        laco_leitura:LOOP
			FETCH semPreReqCursor INTO _nomeDisc;
            IF (final = TRUE) THEN
				LEAVE laco_leitura;
			END IF;
			INSERT INTO tb_semPreReq(t_nomeDisc) VALUES (_nomeDisc);
		END LOOP;
		CLOSE semPreReqCursor;
        SELECT t_nomeDisc FROM tb_semPreReq;
        DROP TEMPORARY TABLE tb_semPreReq;
END//
DELIMITER ;
CALL obter_nomeDisc_sem_preReq();


/* .  
  


11.Obter o nome de cada disciplina que possui ao menos dois pré-requisitos.  */

