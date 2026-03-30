-- Thiago Silva Antenor
-- Funcionou
-- IMPAR

-- =============================================
-- Script de criação de banco para Oficina Automotiva
-- =============================================

CREATE DATABASE IF NOT EXISTS oficina;
USE oficina;

-- =============================================
-- Tabela: veiculos
-- =============================================
CREATE TABLE veiculos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(10) NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    ano_fabricacao INT NOT NULL
);

-- =============================================
-- Tabela: ordens_servico
-- =============================================
CREATE TABLE ordens_servico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT NOT NULL,
    data_abertura DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_veiculo) REFERENCES veiculos(id)
);

-- =============================================
-- Tabela: orcamentos
-- =============================================
CREATE TABLE orcamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_ordem_servico INT NOT NULL,
    valor_estimado DECIMAL(10,2) NOT NULL,
    aprovado BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (id_ordem_servico) REFERENCES ordens_servico(id)
);

-- =============================================
-- Tabela: servicos_realizados
-- =============================================
CREATE TABLE servicos_realizados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_ordem_servico INT NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    valor_real DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_ordem_servico) REFERENCES ordens_servico(id)
);

-- =============================================
-- Tabela: saidas
-- =============================================
CREATE TABLE saidas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_ordem_servico INT NOT NULL,
    data_saida DATE NOT NULL,
    FOREIGN KEY (id_ordem_servico) REFERENCES ordens_servico(id)
);

-- =============================================
-- Inserts de exemplo
-- =============================================

INSERT INTO veiculos (placa, modelo, ano_fabricacao) VALUES
('ABC1234', 'Gol', 2000),
('DEF5678', 'Corsa', 1995),
('GHI9012', 'Palio', 2010);

INSERT INTO ordens_servico (id_veiculo, data_abertura, status) VALUES
(1, '2024-04-10', 'Aberta'),
(2, '2024-04-15', 'Finalizada'),
(3, '2024-05-05', 'Finalizada');

INSERT INTO orcamentos (id_ordem_servico, valor_estimado, aprovado) VALUES
(1, 1500.00, TRUE),
(2, 2000.00, TRUE),
(3, 800.00, FALSE);

INSERT INTO servicos_realizados (id_ordem_servico, descricao, valor_real) VALUES
(1, 'Troca de motor', 1400.00),
(2, 'Revisão geral', 1900.00);

INSERT INTO saidas (id_ordem_servico, data_saida) VALUES
(2, '2024-04-20'),
(3, '2024-05-10');

-- Enunciado da prova IMPAR:
-- baseado no modelo criar uma procedure usando cursor que liste a quantidade de ordem de serviço de veiculos com mais de 20 anos de fabricação ,que tenham tido um orçamento aprovado e realizado, agrupados por mês
-- RESPOSTA:
DELIMITER $
CREATE PROCEDURE pr_lista_qnt_ordem_veiculo_mais_20_fab_orç_aprovado()
BEGIN
	DECLARE final INT DEFAULT 0;
	DECLARE quantidade_ordem_servico INT;
    
	DECLARE ordCur CURSOR FOR	
		SELECT COUNT(ord.id) FROM ordens_servico ord
		INNER JOIN veiculos v ON ord.id_veiculo = v.id
		INNER JOIN orcamentos orc ON orc.id_ordem_Servico = ord.id
		WHERE (SUBSTRING(CURDATE(), 1, 4) - v.ano_fabricacao) > 20 AND
		orc.aprovado = TRUE
		GROUP BY MONTH(ord.data_abertura);
        
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET final = 1;
    OPEN ordCur;
    laco:loop
		FETCH ordCur INTO quantidade_ordem_servico;
		IF final = 1 THEN
			LEAVE laco;
		END IF;
	END LOOP;
    CLOSE ordCur;
    SELECT quantidade_ordem_servico;
END$
DELIMITER ;
CALL pr_lista_qnt_ordem_veiculo_mais_20_fab_orç_aprovado();