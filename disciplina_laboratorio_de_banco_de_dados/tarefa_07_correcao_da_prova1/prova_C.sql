-- turma C

-- TABELA MODELO
CREATE DATABASE bd_academico;
Use bd_academico;
 
-- Criando tabelas:
-- Tabela Pre Requisitos
CREATE TABLE PreReq(
codDeptoPreReq CHAR(5),
    numDiscPreReq INT,
    codDepto CHAR(5),
    numDisc INT
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
codProf INT,
    codDepto CHAR(5),
    codTit INT,
    nomeProf VARCHAR(40)
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
    codProf INT
);
 
-- TB Turma
CREATE TABLE Turma(
anoSem INT,
    codDepto CHAR(5),
    numDisc INT,
    siglaTur CHAR(2),
    capacTur INT
);
 
-- TB Horario
CREATE TABLE Horario(
anoSem INT,
    codDepto CHAR(5),
    numDisc INT,
    siglaTur CHAR(2),
    diaSem INT,
    horaInicio INT,
    numSala INT,
    codPred INT,
    numHoras INT
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
 
-- INSERTS
-- Departamento
-- CRIAR PROCEDURE COM APENAS UMA QUERY DE CURSOR PARA SELECIONAR: Turma C : O nome das disciplinas 
-- e o nome do professor para as turmas cujo a descrição da sala seja 'Salão Nobre'. 
-- Listar no máximo 3 disciplinas do Departamento de Informática.

DELIMITER $$
CREATE PROCEDURE obter_nomeDisc_nomeProf_salao_Nobre()
BEGIN
DECLARE final BOOLEAN DEFAULT FALSE;
    DECLARE _nomeDisc VARCHAR(10);
    DECLARE _nomeProf VARCHAR(40);
    DECLARE _nomeDepto VARCHAR(40);
    DECLARE contadorCod INT DEFAULT 0;
    
 
DECLARE nomeCursor CURSOR FOR
	SELECT  d.nomeDisc, p.nomeProf, dep.nomeDepto from professor p
	INNER JOIN profTurma profT ON profT.codProf = p.codProf
	INNER JOIN turma t ON profT.anoSem = t.anoSem
	   AND profT.codDepto = t.codDepto
	   AND profT.numDisc = t.numDisc
	   AND profT.siglaTur = t.siglaTur
	INNER JOIN disciplina d ON t.codDepto = d.codDepto
	AND t.numDisc = d.numDisc
	INNER JOIN horario h ON h.anoSem = t.anoSem
			AND h.codDepto = t.codDepto
			AND h.numDisc = t.numDisc
			AND h.siglaTur = t.siglaTur
	INNER JOIN sala s ON h.codPred = s.codPred
	  AND h.numSala = s.numSala
	INNER JOIN depto dep ON d.codDepto = dep.codDepto
	WHERE s.descricaoSala = 'Salão Nobre';
	
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET final = TRUE;
    
    CREATE TEMPORARY TABLE tb_nome( t_nomeDisc VARCHAR(10),t_nomeProf VARCHAR(40), t_nomeDepto VARCHAR(40));
-- Executa o CURSOR
    OPEN nomeCursor;
    
    laco_leitura: LOOP
FETCH nomeCursor INTO _nomeDisc, _nomeProf, _nomeDepto;
        IF final THEN
			LEAVE laco_leitura;
		END IF;
        IF _nomeDepto = 'Informática' THEN
				IF contadorCod < 3 THEN
					SET contadorCod = contadorCod + 1;
					INSERT INTO tb_nome (t_nomeDisc, t_nomeProf, t_nomeDepto) VALUES (_nomeDisc, _nomeProf, _nomeDepto);
				END IF;
        ELSE 
			INSERT INTO tb_nome (t_nomeDisc, t_nomeProf, t_nomeDepto) VALUES (_nomeDisc, _nomeProf, _nomeDepto);
        END IF;
END LOOP;
    SELECT t_nomeDisc, t_nomeProf FROM tb_nome;
    DROP TEMPORARY TABLE tb_nome;
    CLOSE nomeCursor;
END$$
DELIMITER ;
CALL obter_nomeDisc_nomeProf_salao_Nobre();
-- Inserção de dados para a tabela Depto
INSERT INTO Depto (CodDepto, NomeDepto) VALUES
('COMP', 'Ciência da Computação'),
('INFO', 'Informática'),
('MAT', 'Matemática'),
('FIS', 'Física');

-- Inserção de dados para a tabela Titulacao
INSERT INTO Titulacao (CodTit, NomeTit) VALUES
(1, 'Graduado'),
(2, 'Mestre'),
(3, 'Doutor'),
(4, 'Pós-Doutor');

-- Inserção de dados para a tabela Professor
INSERT INTO Professor (CodProf, CodDepto, CodTit, NomeProf) VALUES
(101, 'INFO', 3, 'Dr. João Silva'),
(102, 'INFO', 2, 'Ms. Maria Santos'),
(103, 'COMP', 3, 'Dr. Pedro Costa'),
(104, 'MAT', 2, 'Ms. Ana Pereira'),
(105, 'INFO', 1, 'Prof. Carlos Rocha'),
(106, 'COMP', 4, 'Dr. Laura Mendes');

-- Inserção de dados para a tabela Disciplina
INSERT INTO Disciplina (CodDepto, NumDisc, NomeDisc, CreditoDisc) VALUES
('INFO', 101, 'Prog. Avan', 60),
('INFO', 102, 'BD I', 40),
('INFO', 103, 'SO', 60),
('INFO', 104, 'Redes', 40),
('COMP', 201, 'Estr_Dados', 60),
('COMP', 202, 'Algoritmos', 80),
('MAT', 301, 'Cálculo I', 80),
('FIS', 401, 'Física', 60);


-- Inserção de dados para a tabela PreReq (exemplo)
INSERT INTO PreReq (CodDeptoPreReq, NumDiscPreReq, CodDepto, NumDisc) VALUES
('INFO', 102, 'INFO', 101); -- BD I é pré-requisito para Prog. Avan.

-- Inserção de dados para a tabela Turma
INSERT INTO Turma (AnoSem, CodDepto, NumDisc, SiglaTur, CapacTur) VALUES
(20231, 'INFO', 101, 'A', 30),
(20231, 'INFO', 102, 'B', 25),
(20231, 'INFO', 103, 'A', 35),
(20231, 'INFO', 104, 'A', 20),
(20231, 'COMP', 201, 'C', 40),
(20231, 'COMP', 202, 'D', 30),
(20232, 'INFO', 101, 'B', 28),
(20232, 'INFO', 102, 'A', 22),
(20232, 'COMP', 201, 'E', 35);


-- Inserção de dados para a tabela Predio
INSERT INTO Predio (CodPred, NomePred) VALUES
(1, 'Prédio Principal'),
(2, 'Anexo Tecnológico'),
(3, 'Centro de Artes');

-- Inserção de dados para a tabela Sala
INSERT INTO Sala (CodPred, NumSala, DescricaoSala, CapacSala) VALUES
(1, 101, 'Sala de Aula Comum', 40),
(1, 102, 'Salão Nobre', 100), -- Sala especial
(1, 103, 'Laboratório de BD', 25),
(2, 201, 'Sala de Seminários', 50),
(2, 202, 'Salão Nobre', 80), -- Outro Salão Nobre em prédio diferente
(3, 301, 'Atelier de Pintura', 20);

-- Inserção de dados para a tabela Horario
INSERT INTO Horario (AnoSem, CodDepto, NumDisc, SiglaTur, DiaSem, HoraInicio, NumHoras, CodPred, NumSala) VALUES
(20231, 'INFO', 101, 'A', 2, 800, 2, 1, 101), -- Seg 8-10, Sala Comum
(20231, 'INFO', 102, 'B', 3, 1000, 2, 1, 103), -- Ter 10-12, Lab BD
(20231, 'INFO', 103, 'A', 4, 1400, 3, 1, 102), -- Qua 14-17, Salão Nobre (Disciplina INFO)
(20231, 'INFO', 104, 'A', 5, 1600, 2, 2, 201), -- Qui 16-18, Sala Seminários
(20231, 'COMP', 201, 'C', 2, 1400, 3, 2, 202), -- Seg 14-17, Salão Nobre (Disciplina COMP)
(20231, 'COMP', 202, 'D', 3, 800, 4, 1, 101), -- Ter 8-12, Sala Comum
(20232, 'INFO', 101, 'B', 2, 1000, 2, 1, 101), -- Segunda turma de Prog. Avan.
(20232, 'INFO', 102, 'A', 3, 1400, 2, 1, 103);

-- Inserção de dados para a tabela ProfTurma
INSERT INTO ProfTurma (AnoSem, CodDepto, NumDisc, SiglaTur, CodProf) VALUES
(20231, 'INFO', 101, 'A', 101), -- Dr. João Silva leciona Prog. Avan.
(20231, 'INFO', 102, 'B', 102), -- Ms. Maria Santos leciona BD I
(20231, 'INFO', 103, 'A', 101), -- Dr. João Silva leciona SO (Sala Salão Nobre)
(20231, 'INFO', 104, 'A', 105), -- Prof. Carlos Rocha leciona Redes
(20231, 'COMP', 201, 'C', 103), -- Dr. Pedro Costa leciona Estr. Dados (Sala Salão Nobre)
(20231, 'COMP', 202, 'D', 106), -- Dr. Laura Mendes leciona Algoritmos
(20232, 'INFO', 101, 'B', 101),
(20232, 'INFO', 102, 'A', 102);