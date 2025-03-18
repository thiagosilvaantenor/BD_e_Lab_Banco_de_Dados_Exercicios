
-- Tabela do exercício de funcao agregada
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
codPeca CHAR(05),
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

-- Exercício Stored Procedures
-- 1- Procedure para Inserir um registro na Tabela Peça, usando parâmetros;

delimiter //
CREATE PROCEDURE insert_peca (
IN _codPeca CHAR(2), IN _nomePeca VARCHAR(25), IN _corPeca VARCHAR(25),
IN _pesoPeca INT, IN _cidadePeca VARCHAR(50) 
)
BEGIN
	INSERT INTO peca(codPeca, nomePeca, CorPeca, PesoPeca, CidadePeca) 
		VALUES(_codPeca, _nomePeca, _corPeca, _pesoPeca, _cidadePeca);
END//

delimiter ;
-- Teste da Procedure
CALL insert_peca('P4', 'Rolamento', 'Cinza', 16, 'São Paulo');


select * from peca;



-- 2- Procedure para Inserir 8000 registros distintos na Tabela Peça;
delimiter //

CREATE PROCEDURE add_8000_pecas ()
BEGIN
	DECLARE numPeca INT;
    DECLARE codNovo CHAR(04);
    DECLARE i INT DEFAULT 1;
    DECLARE peso INT;
    SELECT FLOOR(RAND() * 100) INTO peso;
    
    
    SET codNovo = CAST( numPeca AS CHAR(04) ) ;
    WHILE i <= 8000 DO
    
			CASE
				WHEN i < 900 THEN SET codNovo = CONCAT('A', i);
				WHEN i > 900 AND i < 1500 THEN SET codNovo = CONCAT('B', i);
				WHEN i > 1500 AND i < 2000 THEN SET codNovo = CONCAT('C', i);
				WHEN i > 2000 AND i < 2500 THEN SET codNovo = CONCAT('D', i);
				WHEN i > 2500 AND i < 3000 THEN SET codNovo = CONCAT('E', i);
				WHEN i > 3000 AND i < 3500 THEN SET codNovo = CONCAT('F', i);
				WHEN i > 3500 AND i < 4000 THEN SET codNovo = CONCAT('D', i);
				WHEN i > 4000 AND i < 4500 THEN SET codNovo = CONCAT('E', i);
				WHEN i > 5000 AND i < 5500 THEN SET codNovo = CONCAT('F', i);
                WHEN i > 5500 AND i < 6000 THEN SET codNovo = CONCAT('G', i);
				WHEN i > 6500 AND i < 7000 THEN SET codNovo = CONCAT('H', i);
				WHEN i > 7500 AND i < 7700 THEN SET codNovo = CONCAT('J', i);
				WHEN i > 7700 AND i <= 8000 THEN SET codNovo = CONCAT('K', i);
                ELSE SET codNovo = CONCAT('Z', i);
			END CASE;
            
			INSERT INTO peca(codPeca, nomePeca, CorPeca, PesoPeca, CidadePeca) 
			VALUES(codNovo, 'Eixo', 'Cinza', peso, 'Mogi das Cruzes');
            SET i = i + 1;
	END WHILE;
END//



delimiter ;
CALL add_8000_pecas();
