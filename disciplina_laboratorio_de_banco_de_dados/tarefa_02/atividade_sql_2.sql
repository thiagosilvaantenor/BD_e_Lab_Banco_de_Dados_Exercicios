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

-- Atualiza tb_classe, para a classe de id 3 estar no 3° andar
UPDATE tb_classe SET id_andar = 3
WHERE id_classe = 3;

-- Inserindo o 10º aluno
INSERT INTO tb_aluno (cod_aluno, nome_aluno, end_aluno, sigla_estado, id_classe)
VALUES
(10, 'GERALT RIVIA', 'RUA X', 'SP', 1);

-- SELECTs básico
-- 1). Queremos selecionar todos os alunos cadastrados.
USE curso;
-- Não usar *, prefira especificar todas as tabelas necessárias para a query
SELECT cod_aluno, nome_aluno,
end_aluno, sigla_estado, id_classe 
FROM tb_aluno;

/* 2). Queremos selecionar todos os nomes de disciplina,
cujo a nota mínima seja maior que 5 ( cinco ). */

SELECT dp.nome_disciplina
FROM tb_disciplina dp
WHERE dp.nota_minima_disciplina > 5;

-- 3). Queremos selecionar todas disciplinas que tenham
-- nota mínima entre 3 (três) e 5 (cinco).
SELECT dp.id_disciplina, dp.nome_disciplina, dp.nota_minima_disciplina FROM tb_disciplina dp
WHERE dp.nota_minima_disciplina >= 3 AND dp.nota_minima_disciplina <= 5;

/*B-    Exercícios de SELECT (Ordenando e agrupando dados)

1). Queremos selecionar todos os alunos em ordem alfabética de nome de aluno, 
e também o número da classe que estuda.
*/
SELECT a.nome_aluno, a.id_classe FROM tb_aluno a 
ORDER BY a.nome_aluno ASC;

-- 2). Selecionaremos o item anterior, porém ordenado alfabeticamente pelo identificador do 
-- aluno de forma descendente  (ascendente é “default”).
SELECT a.cod_aluno, a.nome_aluno, a.id_classe FROM tb_aluno a 
ORDER BY CONVERT(a.cod_aluno, CHAR) DESC;
-- como é pedido ordem alfabetica e o cod_aluno é númerico, é necessário converter ele para Texto/CHAR
-- assim o order by vai ler o número pela tabela ASCII

-- 3). Selecionaremos  todos os alunos que cursam as disciplinas de matemática
-- E de português agrupados por aluno e disciplina.

/* Solução com Intersect, não roda no MYSQL do laboratório
SELECT a.cod_aluno FROM tb_aluno_disciplina ad
WHERE ad.id_disciplina = 'MAT'
INTERSECT
SELECT a.cod_aluno FROM tb_aluno_disciplina ad
WHERE id_disciplina = 'POR'
*/
-- Solução sem INTERSECT
SELECT ad.cod_aluno FROM tb_aluno_disciplina ad
WHERE ad.id_disciplina = 'MAT' AND ad.cod_aluno IN 
(
SELECT ad.cod_aluno FROM tb_aluno_disciplina ad
WHERE id_disciplina = 'POR'
);
-- C-    Exercícios de SELECT (Junção de Tabelas)
-- 1). Queremos selecionar todos os nomes de alunos que cursam Português ou Matemática.
SELECT a.nome_aluno FROM tb_aluno a
INNER JOIN tb_aluno_disciplina ad
ON ad.cod_aluno = a.cod_aluno
INNER JOIN tb_disciplina d
ON ad.id_disciplina = d.id_disciplina
WHERE d.nome_disciplina = 'matemática' OR d.nome_disciplina = 'português';

-- 2). Queremos selecionar todos os nomes de alunos cadastrados que cursam  
-- a disciplina FÍSICA e seus respectivos endereços
SELECT a.nome_aluno, a.end_aluno FROM tb_aluno a
INNER JOIN tb_aluno_disciplina ad
ON ad.cod_aluno = a.cod_aluno
INNER JOIN tb_disciplina d
ON ad.id_disciplina = d.id_disciplina
WHERE d.nome_disciplina = 'Física';

-- 3). Queremos selecionar todos os nomes de alunos cadastrados que cursam física e o 
-- andar que se encontra a classe dos mesmos. Preste atenção ao detalhe da concatenação de
-- uma string "andar" junto à coluna do número do andar (Apenas para estética do resultado).
SELECT a.nome_aluno, 
CONCAT(CAST(c.id_andar AS CHAR(10)), 'º andar') as andar
FROM tb_aluno a
INNER JOIN tb_classe c
ON a.id_classe = c.id_classe
INNER JOIN tb_aluno_disciplina ad
ON ad.cod_aluno = a.cod_aluno
INNER JOIN tb_disciplina d
ON ad.id_disciplina = d.id_disciplina
WHERE d.nome_disciplina LIKE '%fisica%';

-- D-    Exercícios de SELECT (OUTER JOIN)
-- 1.    Selecionar todos os Professores com suas respectivas disciplinas 
-- e os demais Professores que não lecionam disciplina alguma.
SELECT p.id_professor, p.nome_professor,
d.nome_disciplina
from tb_professor p
INNER JOIN tb_disciplina d
ON d.id_professor_disciplina = p.id_professor
UNION
SELECT p.id_professor, p.nome_professor,
d.nome_disciplina
from tb_professor p LEFT OUTER JOIN tb_disciplina d
ON d.id_professor_disciplina = p.id_professor
WHERE d.id_professor_disciplina IS NULL;

/*
E-    Exercícios de SELECT (USE Clausula IN e/ou SUBSelect).
Não pode usar junção.


1.    Selecionar todos os nomes de professores que tenham ministrado disciplina 
para alunos que sejam do Estado do Piaui, cujo a classe tenha sido no terceiro andar.
*/


SELECT p.nome_professor FROM tb_professor p
WHERE p.id_professor IN 
(
	SELECT d.id_professor_disciplina
	FROM tb_disciplina d
	WHERE d.id_disciplina IN 
	(
		SELECT ad.id_disciplina 
		FROM  tb_aluno_disciplina ad
		WHERE ad.cod_aluno IN 
		(
			SELECT a.cod_aluno 
			FROM tb_aluno a
			WHERE a.sigla_estado = 'PI' 
			AND a.id_classe IN 
			(
				SELECT c.id_classe
				FROM tb_classe c
				WHERE c.id_andar = 3
			)
		)
	)
)


