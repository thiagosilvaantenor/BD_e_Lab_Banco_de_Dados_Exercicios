--- Cria o dominio mecanica
CREATE DATABASE mecanica;
GO
USE mecanica; --- Utiliza o dominio criado
GO
CREATE TABLE cliente( --- Cria tabela de clientes
id				INT				NOT NULL IDENTITY(3401,15),----auto incremento começa em 3401 e vai prosseguindo de 15 em 15
nome			VARCHAR(100)	NOT NULL,
logradouro		VARCHAR(200)	NOT NULL,
numero			INT				NOT NULL CHECK(numero > 0), -- Verifica se o numero é positivo
cep				CHAR(8)			NOT NULL CHECK(LEN(cep)= 8), --- Verifica se o cep tem 8 digitos
complemento		VARCHAR(255)	NOT NULL
PRIMARY KEY(id)
)
GO
CREATE TABLE telefone_cliente(
cliente_id		INT				NOT NULL,
telefone		VARCHAR(11)		NOT NULL CHECK(LEN(telefone) = 10 OR LEN(telefone) = 11) -- Verifica se o telefone é fixo (10 digitos) ou celular(11 digitos)
PRIMARY KEY(cliente_id,telefone)
FOREIGN KEY(cliente_id) REFERENCES cliente(id)
)
GO
CREATE TABLE veiculo(
placa			CHAR(7)			NOT NULL CHECK(LEN(placa) = 7),
marca			VARCHAR(30)		NOT NULL,
modelo			VARCHAR(30)		NOT NULL,
cor				VARCHAR(15)		NOT NULL,
ano_fabricacao	INT				NOT NULL ,
ano_modelo		INT				NOT NULL CHECK(ano_modelo > 1997),
data_aquisicao	DATE			NOT NULL,
cliente_id		INT				NOT NULL
PRIMARY KEY(placa),
FOREIGN KEY(cliente_id) REFERENCES cliente(id),
CONSTRAINT ano_modelo_fabricao
							CHECK(ano_fabricacao > 1997) 
							CHECK(ano_modelo = ano_fabricacao OR ano_modelo = ano_fabricacao + 1)
)
GO
CREATE TABLE peca (
id			INT				NOT NULL IDENTITY(3411,7),
nome		VARCHAR(30)		NOT NULL UNIQUE,
preco		DECIMAL(4,2)	NOT NULL CHECK(preco > 0),
estoque		INT				NOT NULL CHECK(estoque >= 10)
PRIMARY KEY(id)
)
GO
CREATE TABLE categoria (
id				INT				NOT NULL IDENTITY(1,1),
categoria_nome	VARCHAR(10)		NOT NULL,
valor_hora		DECIMAL(4,2)	NOT NULL   CHECK(valor_hora >= 0.00),
PRIMARY KEY(id),
CONSTRAINT valor_hora_categoria
							CHECK(
							   (UPPER(categoria_nome) = 'ESTAGIÁRIO' 
							AND valor_hora > 15) 
							OR (UPPER(categoria_nome) = 'NÍVEL 1' 
							AND valor_hora > 25)
							OR (UPPER(categoria_nome) = 'NÍVEL 2'
							AND valor_hora > 35)
							OR (UPPER(categoria_nome) = 'NÍVEL 3'
							AND valor_hora > 50))

)
GO
CREATE TABLE funcionario(
id						INT				NOT NULL IDENTITY(101,1),
nome					VARCHAR(100)	NOT NULL,
logradouro				VARCHAR(200)    NOT NULL,
numero					INT				NOT NULL CHECK(numero > 0),
telefone				CHAR(11)		NOT NULL CHECK(LEN(telefone) = 10 OR LEN(telefone) = 11), -- Verifica se o telefone é fixo(10) ou celular(11)
categoria_habilitacao	VARCHAR(2)		NOT NULL ,
categoria_id			INT				NOT NULL
PRIMARY KEY(id),
FOREIGN KEY(categoria_id) REFERENCES categoria(id),
CONSTRAINT categorias
					CHECK(
					   categoria_habilitacao = 'A'
					OR categoria_habilitacao = 'B'
					OR categoria_habilitacao = 'C'
					OR categoria_habilitacao = 'D'
					OR categoria_habilitacao = 'E'
					)
)
GO
CREATE TABLE reparo(
veiculo_placa	CHAR(7)			NOT NULL,
funcionario_id	INT				NOT NULL,
peca_id			INT				NOT NULL,
data_reparo		DATE			NOT NULL  DEFAULT('15/10/2024'), -- Caso não seja preenchido, coloca a data de hoje
custo_total		DECIMAL(4,2)	NOT NULL  CHECK(custo_total >= 0.00),
tempo			INT				NOT NULL   CHECK(tempo > 0),
PRIMARY KEY(veiculo_placa,funcionario_id,peca_id,data_reparo)
FOREIGN KEY(veiculo_placa) REFERENCES veiculo(placa),
FOREIGN KEY(funcionario_id) REFERENCES funcionario(id),
FOREIGN KEY(peca_id) REFERENCES peca(id)
)
