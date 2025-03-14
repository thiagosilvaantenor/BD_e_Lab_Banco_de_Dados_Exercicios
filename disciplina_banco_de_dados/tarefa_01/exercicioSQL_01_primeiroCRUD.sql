-- Cria banco de dados clinica e j� coloca em uso
CREATE DATABASE clinica;
GO
USE clinica;
GO
--- Cria tabela Paciente
CREATE TABLE paciente (
numBeneficiario		INT					NOT NULL,
nome				VARCHAR(100)		NOT NULL,
logradouro			VARCHAR(200)		NOT NULL,
numero				INT					NOT NULL,
cep					CHAR(8)				NOT NULL,
complemento			VARCHAR(255)		NOT NULL,
telefone			VARCHAR(11)			NOT NULL
PRIMARY KEY(numBeneficiario)
)
GO
--- Cria tabela Especialidade do m�dico
CREATE TABLE especialidade (
id					INT			 		NOT NULL,
especialidade		VARCHAR(100)		NOT NULL
PRIMARY KEY(id)
)
GO
--- Cria tabela Medico
CREATE TABLE medico (
codigo				INT				NOT NULL,
nome				VARCHAR(100)	NOT NULL,
logradouro			VARCHAR(200)	NOT NULL,
endNumero			INT				NOT NULL,
endCep				CHAR(8)			NOT NULL,
endComplemento		VARCHAR(255)	NOT NULL,
contato				VARCHAR(11)		NOT NULL,
especialidadeID		INT				NOT NULL 
PRIMARY KEY(codigo),
FOREIGN KEY(especialidadeID) REFERENCES especialidade(id)
)
GO
-- Cria tabela Consulta
CREATE TABLE consulta(
pacienteNumBeneficiario		INT				NOT NULL,
medicoCodigo				INT				NOT NULL,
dataHora					TIMESTAMP		NOT NULL,
observacao					VARCHAR(255)	NOT NULL
PRIMARY KEY(pacienteNumBeneficiario, medicoCodigo, dataHora)
FOREIGN KEY(pacienteNumBeneficiario) REFERENCES paciente(numBeneficiario),
FOREIGN KEY(medicoCodigo) REFERENCES medico(codigo)
)

--------------------------
GO
-- Inser��o de dados
INSERT INTO paciente VALUES
(99901,'Washington Silva','R. Anhaia',150,'02345000','Casa','922229999'),
(99902,'Luis Ricardo','R. Volunt�rios da P�tria',2251,'03254010','Bloco B. Apto 25','923450987'),
(99903,'Maria Elisa','Av. Aguia de Haia', 1188,'06897020','Apto 1208','912348765'),
(99904,'Jos� Araujo','R. XV de Novembro',18,'03678000','Casa','945674312'),
(99905,'Joana Paula','R. 7 de Abril',97,'01214000','Conjunto 3 - Apto 801', '912095674')

GO

INSERT INTO especialidade VALUES
(1, 'Otorrinolaringologista'),
(2, 'Urologista'),
(3, 'Geriatra'),
(4, 'Pediatra')

GO

INSERT INTO medico VALUES
(100001,'Ana Paula','R. 7 de Setembro', 256,'03698000','Casa', '915689456',1),
(100002,'Maria Aparecida','Av. Brasil',32,'02145070','Casa','923235454',1),
(100003,'Lucas Borges','Av. do Estado', 3210, '05241000','Apto 205', '963698585',2),
(100004,'Gabriel Oliveira','Av. Dom Helder Camara', 350, '03145000','Apto 602','932458745',3)

--------------------------------------
GO

-- Adiciona coluna dia_atendimento para o m�dico
ALTER TABLE medico
ADD dia_atendimento CHAR(8);
GO
---Preenche a coluna dia_atendimento
UPDATE medico
SET dia_atendimento = '2� feira'
WHERE codigo = 100001;
GO
UPDATE medico
SET dia_atendimento = '4� feira'
WHERE codigo = 100002;
GO
UPDATE medico
SET dia_atendimento = '2� feira'
WHERE codigo = 100003;
GO
UPDATE medico
SET dia_atendimento = '5� feira'
WHERE codigo = 100004;

GO

---Deletar especialidade pediatra
DELETE especialidade
WHERE id = 4

GO
---Renomear a coluna dia_atendimento para dia_semana_atendimento
EXEC sp_rename 'dbo.medico.dia_atendimento', 'dia_semana_atendimento', 'COLUMN'
GO
SELECT * FROM medico --Verifica altera��o
GO
-------------------------------------------
--Atualizar endereco do m�dico Lucas Borges para: 
--- Av. Bras Leme, no. 876, apto 504, CEP 02122000

SELECT * FROM medico
WHERE nome = 'Lucas Borges' --Verifica qual o codigo do medico Lucas Borges
GO
UPDATE medico
SET logradouro = 'Av. Bras Leme', endNumero = 876, endCep = '02122000',
endComplemento = 'apto 504'
WHERE codigo = 100003
GO

--Mudar o tipo de dado da coluna observa��o, da tabela consulta
--- para VARCHAR(200)
ALTER TABLE consulta
ALTER COLUMN observacao VARCHAR(200) NOT NULL