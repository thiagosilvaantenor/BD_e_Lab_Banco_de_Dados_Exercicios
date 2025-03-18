
-- Tabela do exercício de funcao agregada
CREATE DATABASE exercicios_funcao_agregada;
Use exercicios_funcao_agregada;
CREATE TABLE peca (
-- Como será adicionado 8000 registros é necessário aumentar a quantidade de CHAR(2) para CHAR(05)
codPeca CHAR(05),
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
-- Como será adicionado 8000 registros é necessário aumentar a quantidade de CHAR(2) para CHAR(05)
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


SELECT codPeca, nomePeca, corPeca, pesoPeca, cidadePeca FROM peca;



-- 2- Procedure para Inserir 8000 registros distintos na Tabela Peça;
delimiter //

CREATE PROCEDURE add_8000_pecas ()
BEGIN
	DECLARE numPeca INT;
    DECLARE codNovo CHAR(05);
    DECLARE i INT DEFAULT 1;
    DECLARE peso INT;
    DECLARE cor VARCHAR(8);
    DECLARE cidade VARCHAR(50);
    WHILE i <= 8000 DO
			
            -- Garante variedade para a cor e peso da peca
            SET cor = CONVERT(HEX(FLOOR(RAND() * 10000000)), CHAR(8));
            SET peso = FLOOR(RAND() * 100) 
            -- TO-DO: 
				-- verificar como fazer array no mysql
                -- fazer random de nome peca
                
            -- Garante que maior variedade do codPeca
			CASE
				WHEN i < 900 THEN 
					SET codNovo = CONCAT('A', i);
					SET cidade = ELT(1,'São Paulo', 'Rio', 'Poa', 'Belo Horizonte', 'Mogi das Cruzes', 'Ouro Preto');
				WHEN i > 900 AND i < 1500 THEN 
					SET codNovo = CONCAT('B', i);
					SET cidade = ELT(2,'São Paulo', 'Rio', 'Poa', 'Belo Horizonte', 'Mogi das Cruzes', 'Ouro Preto');
				WHEN i > 1500 AND i < 2000 THEN 
					SET codNovo = CONCAT('C', i);
					SET cidade = ELT(3,'São Paulo', 'Rio', 'Poa', 'Belo Horizonte', 'Mogi das Cruzes', 'Ouro Preto');
				WHEN i > 2000 AND i < 2500 THEN 
					SET codNovo = CONCAT('D', i);
					SET cidade = ELT(4,'São Paulo', 'Rio', 'Poa', 'Belo Horizonte', 'Mogi das Cruzes', 'Ouro Preto');
				WHEN i > 2500 AND i < 3000 THEN 
					SET codNovo = CONCAT('E', i);
					SET cidade = ELT(5,'São Paulo', 'Rio', 'Poa', 'Belo Horizonte', 'Mogi das Cruzes', 'Ouro Preto');
				WHEN i > 3000 AND i < 3500 THEN 
					SET codNovo = CONCAT('F', i);
                    SET cidade = ELT(6,'São Paulo', 'Rio', 'Poa', 'Belo Horizonte', 'Mogi das Cruzes', 'Ouro Preto');
				WHEN i > 3500 AND i < 4000 THEN 
					SET codNovo = CONCAT('D', i);
                    SET cidade = ELT(2,'São Paulo', 'Rio', 'Poa', 'Belo Horizonte', 'Mogi das Cruzes', 'Ouro Preto');
				WHEN i > 4000 AND i < 4500 THEN 
					SET codNovo = CONCAT('E', i);
					SET cidade = ELT(5,'São Paulo', 'Rio', 'Poa', 'Belo Horizonte', 'Mogi das Cruzes', 'Ouro Preto');
				WHEN i > 5000 AND i < 5500 THEN 
					SET codNovo = CONCAT('F', i);
					SET cidade = ELT(3,'São Paulo', 'Rio', 'Poa', 'Belo Horizonte', 'Mogi das Cruzes', 'Ouro Preto');
                WHEN i > 5500 AND i < 6000 THEN 
					SET codNovo = CONCAT('G', i);
					SET cidade = ELT(6,'São Paulo', 'Rio', 'Poa', 'Belo Horizonte', 'Mogi das Cruzes', 'Ouro Preto');
				WHEN i > 6500 AND i < 7000 THEN 
					SET codNovo = CONCAT('H', i);
					SET cidade = ELT(2,'São Paulo', 'Rio', 'Poa', 'Belo Horizonte', 'Mogi das Cruzes', 'Ouro Preto');
				WHEN i > 7500 AND i < 7700 THEN 
					SET codNovo = CONCAT('J', i);
					SET cidade = ELT(2,'São Paulo', 'Rio', 'Poa', 'Belo Horizonte', 'Mogi das Cruzes', 'Ouro Preto');
				WHEN i > 7700 AND i <= 8000 THEN 
					SET codNovo = CONCAT('K', i);
					SET cidade = ELT(2,'São Paulo', 'Rio', 'Poa', 'Belo Horizonte', 'Mogi das Cruzes', 'Ouro Preto');
                ELSE 
					SET codNovo = CONCAT('Z', i);
					SET cidade = ELT(4,'São Paulo', 'Rio', 'Poa', 'Belo Horizonte', 'Mogi das Cruzes', 'Ouro Preto');
			END CASE;
            

            
            
			INSERT INTO peca(codPeca, nomePeca, CorPeca, PesoPeca, CidadePeca) 
			VALUES(codNovo, 'Eixo', cor, peso, cidade);
            SET i = i + 1;
	END WHILE;
END//


delimiter ;
CALL add_8000_pecas();

SELECT codPeca, nomePeca, corPeca, pesoPeca, cidadePeca FROM peca LIMIT 1000;

SELECT COUNT(codPeca) FROM peca;


