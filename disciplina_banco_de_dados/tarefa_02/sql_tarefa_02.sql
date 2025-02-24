CREATE DATABASE livraria
GO
USE livraria
GO
CREATE TABLE livro (
codigo		INT				NOT NULL	IDENTITY(100001,100),
nome		VARCHAR(200)	NOT NULL,
lingua		VARCHAR(10)     NOT NULL DEFAULT('PT-BR'),
ano			INT				NOT NULL CHECK(ano >= 1990)
PRIMARY KEY(codigo)
)
GO
CREATE TABLE autor (
id			INT				NOT NULL IDENTITY(2351,1),
nome		VARCHAR(100)	NOT NULL UNIQUE,
dt_nasc		DATE			NOT NULL,
pais_nasc	VARCHAR(50)     NOT NULL,
biografia	VARCHAR(255)	NOT NULL
PRIMARY KEY (id),
CONSTRAINT pais_disponivel
			CHECK(UPPER(pais_nasc) = 'BRASIL' 
				OR UPPER(pais_nasc) = 'ESTADOS UNIDOS' 
				OR UPPER(pais_nasc) = 'INGLATERRA' 
				OR UPPER(pais_nasc) = 'ALEMANHA')
)
GO
CREATE TABLE livro_autor (
livro_cod	INT		NOT NULL,
autor_id	INT		NOT NULL
PRIMARY KEY (livro_cod, autor_id)
FOREIGN KEY (livro_cod) REFERENCES livro(codigo),
FOREIGN KEY (autor_id) REFERENCES autor(id)
)
GO
CREATE TABLE editora (
id			INT					NOT NULL	IDENTITY(491,16),
nome		VARCHAR(70)			NOT NULL	UNIQUE,
telefone	VARCHAR(11)			NOT NULL    CHECK(LEN(telefone) = 10),
end_logradouro	VARCHAR(200)	NOT NULL,
end_numero		INT			NOT NULL CHECK(end_numero > 0),
end_cep			CHAR(8)		NOT NULL CHECK(LEN(end_cep) = 8),
end_complemento	VARCHAR(255) NOT NULL
PRIMARY KEY(id)
)
GO
CREATE TABLE edicao (
isbn		CHAR(13)		NOT NULL, CHECK(LEN(isbn) = 13),
preco		DECIMAL(4,2)	NOT NULL CHECK(preco > 0.0),
ano			DATE			NOT NULL CHECK(ano > '31/12/1992'),
num_paginas	INT				NOT NULL CHECK(num_paginas >= 15),
qtd_estoque INT				NOT NULL
PRIMARY KEY(isbn)
)
GO
CREATE TABLE editora_edicao_livro (
editora_id		INT			NOT NULL,
edicao_isbn		CHAR(13)	NOT NULL,
livro_cod		INT			NOT NULL
PRIMARY KEY(editora_id,edicao_isbn,livro_cod)
FOREIGN KEY(editora_id) REFERENCES editora(id),
FOREIGN KEY(edicao_isbn) REFERENCES edicao(isbn),
FOREIGN KEY(livro_cod)	REFERENCES livro(codigo)
)
EXEC sp_help editora
