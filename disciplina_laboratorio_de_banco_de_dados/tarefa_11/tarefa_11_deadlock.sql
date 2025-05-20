SET AUTOCOMMIT = FALSE;
CREATE DATABASE bd_academico;
use bd_academico;
-- Comando da Sessao 1
CREATE TABLE Titulacao(
	codTit INT,
    nomeTit VARCHAR(40)
);
-- Comando da Sessao 1
-- titulacao
ALTER TABLE titulacao
ADD CONSTRAINT PK_TB_titulacao
PRIMARY KEY (codTit);
-- comando da sessão 1
COMMIT ;
-- Comando da Sessão 1
-- -- DADOS PARA TESTE
INSERT INTO titulacao(CodTit, NomeTit) VALUES
(1, 'Mestre'),
(2, 'Doutorado');
COMMIT;

--  Comando da sessão 1
START TRANSACTION;
UPDATE titulacao SET nomeTit = 'Meste 1' WHERE codTit = 1;

-- Comando da sessão 2
Use bd_academico;
START TRANSACTION;
UPDATE titulacao SET nomeTit = 'Doutorado 2' WHERE codTit = 2;
UPDATE titulacao SET nomeTit = 'Meste 2' WHERE codTit = 1;

-- Comando da sessao 1
UPDATE titulacao SET nomeTit = 'Doutorado 1' WHERE codTit = 2; -- DEADLOCK
-- COMMIT


