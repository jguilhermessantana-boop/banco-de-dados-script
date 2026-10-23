CREATE DATABASE feirafacil;
USE feirafacil;

CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    telefone VARCHAR(20)
);

CREATE TABLE produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(200),
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL
);


CREATE TABLE carrinho (
    id_carrinho INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    data_criacao DATE NOT NULL,
    status VARCHAR(30) NOT NULL,
    FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
);

CREATE TABLE itens (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_carrinho INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_carrinho)
        REFERENCES carrinho(id_carrinho),
    FOREIGN KEY (id_produto)
        REFERENCES produto(id_produto)
);

-- Cadastro de clientes
INSERT INTO cliente (nome, cpf, telefone) VALUES
('Carlos Silva', '12345678900', '64999990000'),
('Ana Souza', '98765432100', '64988880000');

-- Cadastro de produtos
INSERT INTO produto (nome, descricao, preco, estoque) VALUES
('Tomate', 'Tomate fresco por kg', 6.50, 50),
('Alface', 'Alface fresca por unidade', 3.00, 30),
('Batata', 'Batata por kg', 5.00, 40);

-- Cadastro de carrinhos
INSERT INTO carrinho (id_cliente, data_criacao, status) VALUES
(1, '2026-10-23', 'Aberto'),
(2, '2026-10-23', 'Aberto');

-- Produtos dentro dos carrinhos
INSERT INTO itens
(id_carrinho, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 2, 6.50),
(1, 2, 1, 3.00),
(2, 3, 3, 5.00);

-- Consultar as quatro tabelas
SELECT * FROM cliente;
SELECT * FROM produto;
SELECT * FROM carrinho;
SELECT * FROM itens;

SELECT
    carrinho.id_carrinho,
    cliente.nome AS cliente,
    produto.nome AS produto,
    itens.quantidade,
    itens.preco_unitario,
    itens.quantidade * itens.preco_unitario AS subtotal
FROM itens
INNER JOIN carrinho
    ON itens.id_carrinho = carrinho.id_carrinho
INNER JOIN cliente
    ON carrinho.id_cliente = cliente.id_cliente
INNER JOIN produto
    ON itens.id_produto = produto.id_produto;
