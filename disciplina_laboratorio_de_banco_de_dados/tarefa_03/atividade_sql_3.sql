CREATE DATABASE exercicios_funcao_agregada;
Use exercicios_funcao_agregada;
CREATE TABLE peca (
codPeca CHAR(02),
nomePeca VARCHAR(25),
corPeca VARCHAR(25),
pesoPeca INT,
cidadePeca VARCHAR(50)
);

ALTER TABLE peca
ADD PRIMARY KEY(codPeca);

CREATE TABLE fornec(
codFornec CHAR(02),
nomeFornec VARCHAR(25),
statusFornec INT,
cidadeFornec VARCHAR(30)
);

ALTER TABLE fornec
ADD PRIMARY KEY(codFornec);

CREATE TABLE embarq (
codPeca CHAR(02),
codFornec CHAR(02),
qtdeEmbarc INT
);

ALTER TABLE embarq
ADD PRIMARY KEY(codPeca, codFornec);

ALTER TABLE embarq
ADD FOREIGN KEY(codPeca) REFERENCES peca(codPeca),
ADD FOREIGN KEY(codFornec) REFERENCES fornec(codFornec);

INSERT INTO peca(codPeca, nomePeca, CorPeca, PesoPeca, CidadePeca) VALUES
('P1', 'Eixo', 'Cinza', 10, 'Poa'),
('P2', 'Rolamento', 'Preto', 16, 'Rio'),
('P3', 'Mancal', 'Verde', 30, 'São Paulo');

INSERT INTO fornec(codFornec, nomeFornec, StatusFornec, CidadeFornec) VALUES
('F1', 'Silva', 5, 'São Paulo'),
('F2', 'Souza', 10, 'Rio'),
('F3', 'Alvares', 5, 'São Paulo'),
('F4', 'Tavares', 8, 'Rio');

INSERT INTO embarq(codPeca, codFornec, qtdeEmbarc) VALUES
('P1', 'F1', 300),
('P1', 'F2', 400),
('P1', 'F3', 200),
('P2', 'F1', 300),
('P2', 'F4', 350);

-- Exercícios

-- 1) Obter o número de fornecedores na base de dados
SELECT COUNT(f.codFornec) as numeroFornecedores FROM fornec f;

-- 2) Obter o número de cidades em que há fornecedores 
SELECT COUNT(DISTINCT f.cidadeFornec) AS qtdCidade FROM fornec f;

-- 3) Obter o número de fornecedores com cidade informada
SELECT COUNT(f.codFornec) as numFornec FROM fornec f
WHERE f.cidadeFornec IS NOT NULL;

-- 4) Obter a quantidade máxima embarcada 
SELECT MAX(e.qtdeEmbarc) AS QntMaxEmbarcada FROM embarq e;

-- 5) Obter o número de embarques de cada fornecedor
SELECT e.codFornec, COUNT(e.codFornec) AS numEmbarquesFornec 
FROM embarq e GROUP BY e.codFornec;

-- )6) Obter o número de embarques de quantidade maior que 300 de cada fornecedor
SELECT e.codFornec, COUNT(e.codFornec) AS numEmbarquesFornec
FROM embarq e 
WHERE e.qtdeEmbarc > 300
GROUP BY e.codFornec;

-- 7) Obter a quantidade total embarcada de peças de cor cinza para cada fornecedor 
SELECT e.codFornec, SUM(e.qtdeEmbarc) AS qntPeca FROM  embarq e
INNER JOIN peca p ON e.codPeca = p.codPeca
WHERE p.CorPeca = 'Cinza'
group by e.CodPeca, e.codFornec;

-- 8) Obter o quantidade total embarcada de peças para cada fornecedor. Exibir o
-- resultado por ordem descendente de quantidade total embarcada. 
SELECT e.codFornec , SUM(e.qtdeEmbarc) AS qntTotalEmbarcada FROM embarq e
GROUP BY e.codFornec
ORDER BY qntTotalEmbarcada DESC;

-- 9) Obter os códigos de fornecedores que tenham embarques de mais de 500 unidades
-- de peças cinzas, junto com a quantidade de embarques de peças cinzas

SELECT e.codFornec, SUM(e.qtdeEmbarc) AS qntEmbarquesPecasCinzas FROM embarq e
INNER JOIN peca p ON e.codPeca = p.codPeca
WHERE p.CorPeca = 'Cinza'
GROUP BY e.codFornec
HAVING SUM(e.qtdeEmbarc) > 500;
-- Atualmente, nenhuma soma de qtdeEmbarc de peças com cor Cinza vai ultrapassar 500 então o resultado está vazio
