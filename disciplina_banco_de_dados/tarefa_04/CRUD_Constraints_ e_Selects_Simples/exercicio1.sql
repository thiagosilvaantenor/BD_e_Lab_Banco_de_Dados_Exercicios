CREATE DATABASE plataforma_projetos
GO
USE plataforma_projetos
GO
---Cria��o das tabelas
--Projetos
CREATE TABLE projects(
id						INT			     NOT NULL IDENTITY(10001,1),
name_project			VARCHAR(45)      NOT NULL,
description_project		VARCHAR(45)      NULL,
date_project			DATE			 NOT NULL CHECK(date_project > '01/09/2014')
PRIMARY KEY(id)
)
GO
---Usu�rios
CREATE TABLE users(
id				INT					NOT NULL IDENTITY(1,1),
name_user		VARCHAR(45)			NOT NULL,
username		VARCHAR(45)			NOT NULL,
password_user	VARCHAR(45)			NOT NULL DEFAULT '123mudar',
email			VARCHAR(45)			NOT NULL
--- Unique precisa estar como constraint de nome especificado para usar o alter table
CONSTRAINT username_unique UNIQUE(username), 
PRIMARY KEY (id)
)
GO
---Para realizar as altera��es necess�rias � preciso retirar o Unique
ALTER TABLE users
DROP CONSTRAINT username_unique;
GO
----- Altera o tamanho do username
ALTER TABLE users
ALTER COLUMN username VARCHAR(10) NOT NULL;
GO
---- Coloca de volta o Unique em username
ALTER TABLE users
ADD CONSTRAINT username_unique UNIQUE(username);
GO
---- Altera o tamanho do password_user
ALTER TABLE users 
ALTER COLUMN password_user VARCHAR(8) NOT NULL;
GO
---- Cria tabela associativa
CREATE TABLE users_has_projects(
users_id		INT			NOT NULL,
projects_id		INT			NOT NULL
PRIMARY KEY(users_id, projects_id)
FOREIGN KEY(users_id) REFERENCES users(id),
FOREIGN KEY(projects_id) REFERENCES projects(id)
)
GO
---INSER��O DE DADOS
---Usuarios
INSERT INTO users VALUES
('Maria',	'Rh_maria',	'123mudar','maria@empresa.com'),
('Paulo','Ti_paulo','123@456','paulo@empresa.com'),
('Ana','Rh_ana', '123mudar','ana@empresa.com'),
('Clara','Ti_clara','123mudar','clara@empresa.com'),
('Aparecido','Rh_apareci','55@!cido','aparecido@empresa.com')
GO
----PROJETOS
INSERT INTO projects VALUES
('Re-folha',		'Refatora��o das Folhas', '05/09/2014'),
('Manuten��o PCs',	'Manuten��o PCs',	'06/09/2014'),
('Auditoria',NULL,'07/09/2014')
GO
----- Tabela associativa de Usuarios e Projetos
INSERT INTO users_has_projects VALUES
(1,10001),
(5,10001),
(3,10003),
(4,10002),
(2,10002)

-----Muda a data do projeto Manuten��o de PCs
UPDATE projects SET
date_project = '12/09/2014'
WHERE name_project LIKE '%Manuten��o PCs%'
------
---Mudar o username de aparecido, usando o nome como condi��o para mudan�a
UPDATE users SET
username = 'Rh_cido'
WHERE name_user = 'Aparecido'
--------------------

---Mudar o password do username Rh_maria(usar o username como condi��o)
--- e verificar se o password atual ainda � 123mudar
UPDATE users SET
password_user = '888@*'
WHERE username = 'Rh_maria' AND password_user = '123mudar'
-------------

----Remover, da tabela associativa, o user de id 2 pois o mesmo n�o participa mais do projeto 10002
DELETE FROM users_has_projects
WHERE users_id = 2 AND projects_id = 10002
