CREATE DATABASE curso;
USE curso;

CREATE TABLE tb_estado (
	sigla_estado CHAR(2),
	nome_estado VARCHAR(40)
);

-- Chave primaria
ALTER TABLE tb_estado
ADD CONSTRAINT Pk_tb_estado
PRIMARY KEY (sigla_estado);

-- Tabela 
CREATE TABLE tb_aluno (
	cod_aluno SMALLINT,
	nome_aluno VARCHAR(45),
    end_aluno VARCHAR(100),
	sigla_estado CHAR(2),
	id_classe SMALLINT
);

-- Chave primaria
ALTER TABLE tb_aluno
ADD CONSTRAINT PK_tb_aluno
PRIMARY KEY (cod_aluno);

CREATE TABLE tb_classe (
	id_classe SMALLINT,
    id_andar SMALLINT
);

-- Chave primaria
ALTER TABLE tb_classe
ADD CONSTRAINT PK_tb_classe
PRIMARY KEY (id_classe);

CREATE TABLE tb_aluno_disciplina (
	cod_aluno SMALLINT,
    id_disciplina CHAR(3),
    nota_aluno SMALLINT
);

-- Chave primaria
ALTER TABLE tb_aluno_disciplina
ADD CONSTRAINT PK_tb_aluno_disciplina
PRIMARY KEY (cod_aluno, id_disciplina);

CREATE TABLE tb_professor (
	id_professor CHAR(3),
    nome_professor VARCHAR(25)
);

-- Chave primaria
ALTER TABLE tb_professor
ADD CONSTRAINT PK_tb_professor
PRIMARY KEY (id_professor);

CREATE TABLE tb_disciplina (
	id_disciplina CHAR(3),
    nome_disciplina VARCHAR(15),
    id_professor_disciplina CHAR(3),
    nota_minima_disciplina SMALLINT
);

-- Chave primaria
ALTER TABLE tb_disciplina
ADD CONSTRAINT Pk_tb_disciplina
PRIMARY KEY (id_disciplina);

-- Chaves estrangeiras
-- tb_aluno e tb_estado
ALTER TABLE tb_aluno
ADD CONSTRAINT FK_tb_aluno_tb_estado
FOREIGN KEY(sigla_estado) REFERENCES tb_estado(sigla_estado);

-- tb_aluno e tb_classe
ALTER TABLE tb_aluno
ADD CONSTRAINT FK_tb_aluno_tb_classe
FOREIGN KEY(id_classe) REFERENCES tb_classe(id_classe);

-- tb_aluno_disciplina e tb_aluno
ALTER TABLE tb_aluno_disciplina
ADD CONSTRAINT FK_tb_aluno_disciplina_aluno
FOREIGN KEY(cod_aluno) REFERENCES tb_aluno(cod_aluno);

-- tb_aluno_disciplina e tb_disciplina
ALTER TABLE tb_aluno_disciplina
ADD CONSTRAINT FK_tb_aluno_disciplina_disciplina
FOREIGN KEY(id_disciplina) REFERENCES tb_disciplina(id_disciplina);

-- tb_disciplina e tb_professor
ALTER TABLE tb_disciplina
ADD CONSTRAINT FK_tb_disciplina_professor
FOREIGN KEY(id_professor_disciplina) REFERENCES tb_professor(id_professor);

-- Inserção de dados:

-- TB professor
INSERT INTO tb_professor (id_professor, nome_professor) 
VALUES
	('JOI', 'JOILSON CARDOSO'),
	('OSE', 'OSEAS SANTANA'),
	('VIT',  'VITOR VASCONCELOS'),
	('FER', 'JOSE ROBERTO FERROLI'),
	('LIM', 'VALMIR LIMA'),
	('EDS', 'EDSON SILVA'),
	('WAG', 'WAGNER OKIDA');
    
-- TB disciplina

INSERT INTO tb_disciplina (ID_DISCIPLINA, NOME_DISCIPLINA, ID_PROFESSOR_DISCIPLINA, NOTA_MINIMA_DISCIPLINA)
VALUES
('MAT', 'MATEMATICA', 'JOI', 7), 
('POR', 'PORTUGUES', 'VIT', 5), 
('FIS', 'FISICA', 'OSE', 3), 
('HIS', 'HISTORIA', 'EDS', 2), 
('GEO', 'GEOGRAFIA', 'WAG', 4), 
('ING', 'INGLES', 'LIM', 2); 

-- TB classe
INSERT INTO tb_classe (id_classe, id_andar)
VALUES
(1, 1),
(2, 1),
(3, 1);

-- TB estado
INSERT INTO tb_estado (sigla_estado, nome_estado)
VALUES
('SP', 'São Paulo');
-- TB Aluno
INSERT INTO tb_aluno (cod_aluno, nome_aluno, end_aluno, sigla_estado, id_classe)
VALUES
(1, 'ANTONIO CARLOS PENTEADO', 'RUA X', 'SP', 1),
(2, 'AUROMIR DA SILVA VALDEVINO', 'RUA W', 'SP', 1 ),
(3, 'ANDRE COSTA', 'RUA T','SP', 1 ),
(4, 'ROBERTO SOARES DE MENEZES', 'RUA BW', 'SP', 2), 
(5, 'DANIA', 'RUA CCC', 'SP', 2), 
(6, 'CARLOS MAGALHAES', 'AV SP', 'SP', 2), 
(7, 'MARCELO RAUBA', 'AV SAO LUIS', 'SP', 3), 
(8, 'FERNANDO', 'AV COUNTYR', 'SP', 3), 
(9, 'WALMIR BURIN', 'RUA SSISIS', 'SP', 3);

-- TB_ALUNO_DISCIPLINA
INSERT INTO tb_aluno_disciplina (cod_aluno, id_disciplina, nota_aluno)
VALUES
(1, 'MAT', 0), 
(2, 'MAT', 0),
(3, 'MAT', 1),
(4, 'POR', 2),
(5, 'POR', 2),
(6, 'POR', 2),
(7, 'FIS', 3),
(8, 'FIS', 3), 
(9, 'FIS', 3),
(1, 'POR', 2), 
(2, 'POR', 2), 
(7, 'POR', 2), 
(1, 'FIS', 3); 

SELECT * FROM tb_aluno_disciplina