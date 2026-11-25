CREATE DATABASE investigacao_criminal;
USE investigacao_criminal;

CREATE TABLE Pessoa (
	idPessoa INT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    dataNasc DATE,
    CPF CHAR(11) UNIQUE
);

CREATE TABLE Investigador (
	idInvestigador INT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    matricula VARCHAR(20) UNIQUE NOT NULL,
    cargo VARCHAR(45) 
);

CREATE TABLE Caso (
	idCaso INT PRIMARY KEY,
    idInvestigador INT NOT NULL, 
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT,
    dataAbertura DATETIME, 
    statusCaso VARCHAR(45),
    dataEncerramento DATETIME,
    
    FOREIGN KEY (idInvestigador)
		REFERENCES Investigador(idInvestigador)
);

CREATE TABLE Evidencia (
	idEvidencia INT PRIMARY KEY,
    idCaso INT NOT NULL,
    descricao TEXT,
    tipo VARCHAR(45),
    dataColeta DATETIME,
    localColeta VARCHAR(45),
    
    FOREIGN KEY(idCaso)
		REFERENCES Caso(idCaso)
    
);

CREATE TABLE Envolvimento(
	idEnvolvimento INT PRIMARY KEY,
    idCaso INT NOT NULL,
    idPessoa INT NOT NULL,
    tipoEnvolvimento VARCHAR(45),
    
    FOREIGN KEY (idCaso)
        REFERENCES Caso(idCaso),

    FOREIGN KEY (idPessoa)
        REFERENCES Pessoa(idPessoa)
);

CREATE TABLE Depoimento(
	idDepoimento INT PRIMARY KEY,
    idCaso INT NOT NULL,
    idPessoa INT NOT NULL,
	idInvestigador INT NOT NULL, 
    relato TEXT,
    dataDepoimento DATETIME,
    
    FOREIGN KEY (idCaso)
        REFERENCES Caso(idCaso),

    FOREIGN KEY (idPessoa)
        REFERENCES Pessoa(idPessoa), 
        
	FOREIGN KEY (idInvestigador)
        REFERENCES Investigador(idInvestigador)
);
 
SHOW TABLES; # Mostra as tabelas existentes 
DESCRIBE Pessoa; # Visualiza a estrutura da tabela
SELECT * FROM Pessoa; # Visualiza os registros

INSERT INTO Pessoa (idPessoa, nome, dataNasc, CPF) VALUES 
	(1, 'Carlos Almeida', '1995-05-15', '00000000001'),
	(2, 'Mariana Almeida', '1999-07-09', '00000000002'),
	(3, 'Henrique Vieira', '2000-12-22', '00000000003'),
	(4, 'Juliana Piza', '1990-01-10', '00000000004'),
    (5, 'Pedro Henrique Piza', '1992-02-02', '00000000005'); 

SELECT * FROM Pessoa;

INSERT INTO Investigador (idInvestigador, nome, matricula, cargo) VALUES
    (1, 'Jonny Albert', 'INV001', 'Delegado'),
    (2, 'Ricardo Mendes', 'INV002', 'Investigador'),
    (3, 'Fernanda Costa', 'INV003', 'Escrivã'),
    (4, 'Gustavo Ribeiro', 'INV004', 'Investigador'),
    (5, 'Marcelo Oliveira', 'INV005', 'Delegado');
    
SELECT * FROM Investigador;

INSERT INTO Caso (idCaso, idInvestigador, titulo, descricao, dataAbertura, statusCaso, dataEncerramento) VALUES
    (1, 1, 'Furto de veículo', 'Veículo furtado em estacionamento comercial.', '2026-10-15 08:30:00', 'Em investigação', NULL),
    (2, 2, 'Roubo de celular', 'Celular roubado em via pública.', '2026-10-18 14:20:00', 'Concluído', '2026-10-25 16:00:00'),
    (3, 3, 'Fraude bancária', 'Movimentações financeiras não autorizadas em conta bancária.', '2026-11-01 09:15:00', 'Em investigação', NULL),
    (4, 4, 'Desaparecimento de pessoa', 'Pessoa desaparecida após sair de sua residência.', '2026-11-10 18:45:00', 'Aberto', NULL),
    (5, 1, 'Invasão de propriedade', 'Entrada não autorizada em propriedade particular.', '2026-11-12 11:30:00', 'Arquivado', '2026-11-20 15:00:00');

SELECT * FROM Caso;

INSERT INTO Evidencia (idEvidencia, idCaso, descricao, tipo, dataColeta, localColeta) VALUES
    (1, 1, 'Imagens da câmera de segurança.', 'Digital', '2026-10-15 10:30:00', 'Estacionamento comercial'),
    (2, 2, 'Celular recuperado durante a investigação.', 'Material', '2026-10-20 15:20:00', 'Residência do suspeito'),
    (3, 3, 'Extratos bancários com transações suspeitas.', 'Documental', '2026-11-02 09:30:00', 'Agência bancária'),
    (4, 4, 'Mochila pertencente à pessoa desaparecida.', 'Material', '2026-11-11 14:10:00', 'Praça central'),
    (5, 1, 'Fotografias do local do furto.', 'Digital', '2026-10-15 11:45:00', 'Estacionamento comercial');

SELECT * FROM Evidencia;

INSERT INTO Envolvimento (idEnvolvimento, idCaso, idPessoa, tipoEnvolvimento) VALUES
    (1, 1, 1, 'Vítima'),
    (2, 1, 2, 'Testemunha'),
    (3, 2, 3, 'Suspeito'),
    (4, 3, 4, 'Vítima'),
    (5, 4, 5, 'Desaparecido');

SELECT * FROM Envolvimento;

INSERT INTO Depoimento (idDepoimento, idCaso, idPessoa, idInvestigador, relato, dataDepoimento) VALUES
    (1, 1, 1, 1, 'Relatou que deixou o veículo no estacionamento e, ao retornar, ele não estava mais no local.', '2026-10-15 13:30:00'),
    (2, 1, 2, 1, 'Afirmou ter observado uma movimentação suspeita próxima ao veículo.', '2026-10-16 09:00:00'),
    (3, 2, 3, 2, 'Negou participação no roubo do aparelho celular.', '2026-10-21 14:30:00'),
    (4, 3, 4, 3, 'Informou que identificou transações desconhecidas em sua conta bancária.', '2026-11-02 11:00:00'),
    (5, 1, 2, 1, 'Apresentou informações complementares sobre o ocorrido.', '2026-10-17 15:20:00');

SELECT * FROM Depoimento;

# Investigadores com cargo de Delegado
SELECT * FROM Investigador
WHERE cargo = 'Delegado';

# Casos em Investigação
SELECT * FROM Caso
WHERE statusCaso = 'Em investigação';

# Evidências do tipo Digital
SELECT * FROM Evidencia
WHERE tipo = 'Digital';

# Pessoas envolvidas como Vítimas
SELECT * FROM Envolvimento
WHERE tipoEnvolvimento = 'Vítima';

# Depoimentos relacionados ao Caso 1
SELECT * FROM Depoimento
WHERE idCaso = 1;

# Pessoas nascidas a partir de 1995
SELECT * FROM Pessoa
WHERE dataNasc >= '1995-01-01';