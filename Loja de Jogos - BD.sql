CREATE DATABASE Loja;

USE Loja;

CREATE TABLE Jogo (
	idJogo SERIAL NOT NULL,
	nomeJogo VARCHAR(50) NOT NULL,
	genero VARCHAR(20),
	precoUnidade DECIMAL(5, 2) NOT NULL);
	
ALTER TABLE Jogo ADD PRIMARY KEY (idJogo);

CREATE TABLE Fornecedor (
	idFornecedor SERIAL NOT NULL,
	nomeFornecedor VARCHAR(50) NOT NULL);
	
ALTER TABLE Fornecedor ADD PRIMARY KEY (idFornecedor);	

CREATE TABLE Fornece (
	idFornecedor SERIAL NOT NULL,
	idJogo INT NOT NULL);
	
CREATE TABLE Loja (
	idLoja SERIAL NOT NULL,
	nomeLoja VARCHAR(50) NOT NULL,
	emailLoja VARCHAR(50),
	telefoneLoja INT,
	coordenadas INT);
	
ALTER TABLE Loja ADD PRIMARY KEY (idLoja);

CREATE TABLE Cidade (
	coordenadas INT UNIQUE NOT NULL,
	nomeCidade VARCHAR(50),
	estado VARCHAR(50));
	
ALTER TABLE Cidade ADD PRIMARY KEY (coordenadas);

CREATE TABLE Possui (
	idJogo INT NOT NULL,
	idLoja INT NOT NULL);
	
CREATE TABLE Funcionario (
	idFuncionario SERIAL NOT NULL,
	nomeFuncionario VARCHAR(50) NOT NULL,
	salario DECIMAL(10, 2),
	telefoneFuncionario INT,
	idLoja INT NOT NULL);
	
ALTER TABLE Funcionario ADD PRIMARY KEY (idFuncionario);

CREATE TABLE Atendente (
	idFuncionario INT NOT NULL,
	turno VARCHAR(5) NOT NULL);
	

CREATE TABLE Gerente (
	idFuncionario INT NOT NULL,
	dataInicio DATE,
	dataFim DATE);
	
CREATE TABLE Review (
	idReview SERIAL NOT NULL
	idCliente INT NOT NULL,
	nota DECIMAL (5, 2),
	idJogo INT NOT NULL);
	
ALTER TABLE Review ADD PRIMARY KEY (idReview);
	
CREATE TABLE Cliente (
	idCliente SERIAL NOT NULL,
	nomeCliente VARCHAR(50) NOT NULL,
	telefoneCliente INT,
	emailCliente VARCHAR(50) NOT NULL,
	idLoja INT NOT NULL);
	
ALTER TABLE Cliente ADD PRIMARY KEY (idCliente);

CREATE TABLE Compra (
	idCliente INT NOT NULL,
	idJogo INT NOT NULL,
	preco DECIMAL(10, 2) NOT NULL,
	quantidade INT NOT NULL,
	data DATE);


INSERT INTO Atendente (idFuncionario, turno) values (1, 'tarde');

INSERT INTO Cidade (coordenadas, nomeCidade, estado) VALUES (2561084, 'Pelotas', 'Rio Grande do Sul');

INSERT INTO Cliente (nomeCliente, telefoneCliente, emailCliente, idLoja) VALUES ('Ricardo Fernandes Roos', 981550880, 'ric@gmail.com', 1);

INSERT INTO Loja (nomeLoja, emailLoja, telefoneLoja, coordenadas) VALUES ('lolja', 'lolja@gmail.com', 32275507, 2561084);

INSERT INTO Compra (idCliente, idJogo, preco, quantidade, data) VALUES (1, 1, 60, 1, '2022-05-12');

INSERT INTO Fornece (idFornecedor, idJogo) VALUES (1, 1);

INSERT INTO Fornecedor (nomeFornecedor) VALUES ('forngames');

INSERT INTO Funcionario (nomeFuncionario, salario, telefoneFuncionario, idLoja) VALUES ('jorge', 3000, 986532144, 1);

INSERT INTO Funcionario (nomeFuncionario, salario, telefoneFuncionario, idLoja) VALUES ('vic', 4000, 991488566, 1);

INSERT INTO Gerente (idFuncionario, dataInicio, dataFim) VALUES (2, '2021-05-06', '2022-05-07');

INSERT INTO Jogo (nomeJogo, genero, precoUnidade) VALUES ('elden crown', 'rpg', 60);

INSERT INTO Possui (idJogo, idLoja) VALUES (1, 1);

INSERT INTO Review (idCliente, nota, idJogo) VALUES (1, 7, 1);

ALTER TABLE Atendente ADD FOREIGN KEY (idFuncionario) REFERENCES Funcionario (idFuncionario) ON UPDATE CASCADE;

ALTER TABLE Cliente ADD FOREIGN KEY (idLoja) REFERENCES Loja (idLoja);

ALTER TABLE Compra ADD FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente) ON UPDATE CASCADE;

ALTER TABLE Compra ADD FOREIGN KEY (idJogo) REFERENCES Jogo (idJogo) ON UPDATE CASCADE;

ALTER TABLE Fornece ADD FOREIGN KEY (idFornecedor) REFERENCES Fornecedor (idFornecedor) ON UPDATE CASCADE;

ALTER TABLE Fornece ADD FOREIGN KEY (idJogo) REFERENCES Jogo (idJogo) ON UPDATE CASCADE;

ALTER TABLE Funcionario ADD FOREIGN KEY (idLoja) REFERENCES Loja (idLoja);

ALTER TABLE Gerente ADD FOREIGN KEY (idFuncionario) REFERENCES Funcionario (idFuncionario) ON UPDATE CASCADE;

ALTER TABLE Loja ADD FOREIGN KEY (coordenadas) REFERENCES Cidade (coordenadas) ON UPDATE CASCADE;

ALTER TABLE Possui ADD FOREIGN KEY (idJogo) REFERENCES Jogo (idJogo) ON UPDATE CASCADE;

ALTER TABLE Possui ADD FOREIGN KEY (idLoja) REFERENCES Loja (idLoja) ON UPDATE CASCADE;

ALTER TABLE Review ADD FOREIGN KEY (idJogo) REFERENCES Jogo (idJogo) ON UPDATE CASCADE;

ALTER TABLE Review ADD FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente) ON UPDATE CASCADE;


select cliente.nomecliente, loja.nomeloja from
	cliente
	inner join loja on cliente.idloja = loja.idloja;

select fornecedor.nomefornecedor, jogo.nomejogo from
	fornecedor
	inner join fornece on fornece.idfornecedor = fornecedor.idfornecedor
	inner join jogo on fornece.idjogo = jogo.idjogo;

select loja.nomeloja, jogo.nomejogo from
	loja
	inner join possui on possui.idloja = loja.idloja
	inner join jogo on possui.idjogo = jogo.idjogo;

select funcionario.nomefuncionario, funcionario.salario, loja.nomeloja from
	funcionario
	inner join loja on funcionario.idloja = loja.idloja;

select jogo.nomejogo, jogo.genero from jogo
	where jogo.precounidade >= 10;

select review.nota from review
	where review.idjogo = 10;

select avg(review.nota) as "media", jogo.nomejogo
    from review 
    inner join jogo on jogo.idjogo = review.idjogo
    group by jogo.nomejogo;

