-- =====================================================================
-- Atividade III - SEDUC DEST2
-- Banco de dados: livraria_pagina_viva (Livraria online "Página Viva")
-- SGBD: MySQL 8 / MariaDB 10.x
-- =====================================================================

DROP DATABASE IF EXISTS livraria_pagina_viva;
CREATE DATABASE livraria_pagina_viva
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE livraria_pagina_viva;

-- ---------------------------------------------------------------------
-- ESTRUTURA (DDL)
-- ---------------------------------------------------------------------

CREATE TABLE categorias (
  id_categoria INT AUTO_INCREMENT PRIMARY KEY,
  nome         VARCHAR(60) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE editoras (
  id_editora INT AUTO_INCREMENT PRIMARY KEY,
  nome       VARCHAR(100) NOT NULL,
  cidade     VARCHAR(60)  NOT NULL,
  uf         CHAR(2)      NOT NULL
) ENGINE=InnoDB;

CREATE TABLE autores (
  id_autor      INT AUTO_INCREMENT PRIMARY KEY,
  nome          VARCHAR(100) NOT NULL,
  nacionalidade VARCHAR(50)  NOT NULL
) ENGINE=InnoDB;

CREATE TABLE livros (
  id_livro        INT AUTO_INCREMENT PRIMARY KEY,
  titulo          VARCHAR(150)  NOT NULL,
  isbn            CHAR(13)      NOT NULL UNIQUE,
  ano_publicacao  SMALLINT      NOT NULL,
  preco           DECIMAL(8,2)  NOT NULL CHECK (preco > 0),
  estoque         INT           NOT NULL DEFAULT 0 CHECK (estoque >= 0),
  id_editora      INT NOT NULL,
  id_categoria    INT NOT NULL,
  FOREIGN KEY (id_editora)   REFERENCES editoras(id_editora),
  FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
) ENGINE=InnoDB;

-- Relacionamento N:N entre livros e autores
CREATE TABLE livro_autor (
  id_livro INT NOT NULL,
  id_autor INT NOT NULL,
  PRIMARY KEY (id_livro, id_autor),
  FOREIGN KEY (id_livro) REFERENCES livros(id_livro),
  FOREIGN KEY (id_autor) REFERENCES autores(id_autor)
) ENGINE=InnoDB;

CREATE TABLE clientes (
  id_cliente     INT AUTO_INCREMENT PRIMARY KEY,
  nome           VARCHAR(100) NOT NULL,
  email          VARCHAR(120) NOT NULL UNIQUE,
  cpf            CHAR(11)     NOT NULL UNIQUE,
  cidade         VARCHAR(60)  NOT NULL,
  uf             CHAR(2)      NOT NULL,
  data_cadastro  DATE         NOT NULL
) ENGINE=InnoDB;

-- Atributo multivalorado: telefones (4FN)
CREATE TABLE cliente_telefones (
  id_telefone INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente  INT NOT NULL,
  numero      VARCHAR(15) NOT NULL,
  tipo        ENUM('celular','residencial','comercial') NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
) ENGINE=InnoDB;

-- Atributo multivalorado independente: categorias de interesse (4FN)
CREATE TABLE cliente_interesses (
  id_cliente   INT NOT NULL,
  id_categoria INT NOT NULL,
  PRIMARY KEY (id_cliente, id_categoria),
  FOREIGN KEY (id_cliente)   REFERENCES clientes(id_cliente),
  FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
) ENGINE=InnoDB;

CREATE TABLE pedidos (
  id_pedido        INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente       INT NOT NULL,
  data_pedido      DATE NOT NULL,
  status           ENUM('Pendente','Pago','Enviado','Entregue','Cancelado') NOT NULL DEFAULT 'Pendente',
  forma_pagamento  ENUM('Pix','Cartão de crédito','Boleto') NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
) ENGINE=InnoDB;

-- Relacionamento N:N entre pedidos e livros (com atributos próprios)
CREATE TABLE itens_pedido (
  id_pedido       INT NOT NULL,
  id_livro        INT NOT NULL,
  quantidade      INT NOT NULL CHECK (quantidade > 0),
  preco_unitario  DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (id_pedido, id_livro),
  FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
  FOREIGN KEY (id_livro)  REFERENCES livros(id_livro)
) ENGINE=InnoDB;

-- Relacionamento 1:1 com pedidos
CREATE TABLE notas_fiscais (
  id_nota       INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido     INT NOT NULL UNIQUE,
  numero        VARCHAR(10)   NOT NULL UNIQUE,
  data_emissao  DATE          NOT NULL,
  valor_total   DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- DADOS (DML) - todos fictícios
-- ---------------------------------------------------------------------

INSERT INTO categorias (nome) VALUES
('Romance'), ('Poesia'), ('Teatro'), ('Infantil'), ('Tecnologia'), ('Didático');

INSERT INTO editoras (nome, cidade, uf) VALUES
('Editora Horizonte', 'São Paulo',      'SP'),
('Letras do Sul',     'Porto Alegre',   'RS'),
('Casa do Sertão',    'Salvador',       'BA'),
('Ponte Nova',        'Belo Horizonte', 'MG'),
('Tecnoprint',        'Recife',         'PE');

INSERT INTO autores (nome, nacionalidade) VALUES
('Machado de Assis',          'Brasileira'),
('Jorge Amado',               'Brasileira'),
('João Guimarães Rosa',       'Brasileira'),
('Clarice Lispector',         'Brasileira'),
('Carlos Drummond de Andrade','Brasileira'),
('Cecília Meireles',          'Brasileira'),
('Ariano Suassuna',           'Brasileira'),
('Monteiro Lobato',           'Brasileira'),
('Ana Ribeiro',               'Brasileira'),
('Carlos Menezes',            'Portuguesa');

INSERT INTO livros (titulo, isbn, ano_publicacao, preco, estoque, id_editora, id_categoria) VALUES
('Dom Casmurro',                     '9780000000011', 1899, 39.90, 25, 1, 1),
('Memórias Póstumas de Brás Cubas',  '9780000000028', 1881, 42.50, 18, 1, 1),
('Capitães da Areia',                '9780000000035', 1937, 49.90, 30, 3, 1),
('Grande Sertão: Veredas',           '9780000000042', 1956, 79.90,  8, 3, 1),
('A Hora da Estrela',                '9780000000059', 1977, 34.90, 22, 2, 1),
('Antologia Poética',                '9780000000066', 1962, 44.00, 12, 4, 2),
('Romanceiro da Inconfidência',      '9780000000073', 1953, 38.00,  6, 4, 2),
('Auto da Compadecida',              '9780000000080', 1955, 36.50, 15, 2, 3),
('Reinações de Narizinho',           '9780000000097', 1931, 29.90, 40, 1, 4),
('Banco de Dados na Prática',        '9780000000103', 2021, 89.90, 10, 5, 5);

INSERT INTO livro_autor (id_livro, id_autor) VALUES
(1, 1), (2, 1), (3, 2), (4, 3), (5, 4),
(6, 5), (7, 6), (8, 7), (9, 8), (10, 9), (10, 10);

INSERT INTO clientes (nome, email, cpf, cidade, uf, data_cadastro) VALUES
('Mariana Souza',    'mariana.souza@gmail.com',  '11111111111', 'São Paulo',      'SP', '2025-03-10'),
('Pedro Almeida',    'pedro.almeida@outlook.com','22222222222', 'Rio de Janeiro', 'RJ', '2025-05-22'),
('Juliana Costa',    'juliana.costa@gmail.com',  '33333333333', 'Belo Horizonte', 'MG', '2025-08-14'),
('Rafael Lima',      'rafael.lima@yahoo.com',    '44444444444', 'Salvador',       'BA', '2025-11-02'),
('Camila Ferreira',  'camila.ferreira@gmail.com','55555555555', 'Porto Alegre',   'RS', '2026-01-18'),
('Lucas Martins',    'lucas.martins@hotmail.com','66666666666', 'Recife',         'PE', '2026-02-27'),
('Fernanda Rocha',   'fernanda.rocha@gmail.com', '77777777777', 'São Paulo',      'SP', '2026-04-05'),
('Bruno Carvalho',   'bruno.carvalho@outlook.com','88888888888','Curitiba',       'PR', '2026-06-30');

INSERT INTO cliente_telefones (id_cliente, numero, tipo) VALUES
(1, '(11) 98888-1111', 'celular'),
(1, '(11) 3333-1111',  'residencial'),
(2, '(21) 97777-2222', 'celular'),
(3, '(31) 96666-3333', 'celular'),
(4, '(71) 95555-4444', 'celular'),
(5, '(51) 94444-5555', 'celular'),
(6, '(81) 93333-6666', 'celular'),
(7, '(11) 2222-7777',  'comercial'),
(8, '(41) 92222-8888', 'celular');

INSERT INTO cliente_interesses (id_cliente, id_categoria) VALUES
(1, 1), (1, 2), (2, 5), (3, 1), (4, 3), (5, 2), (6, 5), (7, 4), (8, 5);

INSERT INTO pedidos (id_cliente, data_pedido, status, forma_pagamento) VALUES
(1, '2026-01-12', 'Entregue',  'Pix'),
(2, '2026-02-03', 'Entregue',  'Cartão de crédito'),
(3, '2026-02-20', 'Entregue',  'Boleto'),
(1, '2026-03-15', 'Entregue',  'Cartão de crédito'),
(4, '2026-04-08', 'Enviado',   'Pix'),
(5, '2026-05-19', 'Pago',      'Pix'),
(6, '2026-06-02', 'Cancelado', 'Boleto'),
(7, '2026-07-21', 'Enviado',   'Cartão de crédito'),
(2, '2026-09-14', 'Pago',      'Pix'),
(8, '2026-10-30', 'Pendente',  'Boleto');

INSERT INTO itens_pedido (id_pedido, id_livro, quantidade, preco_unitario) VALUES
(1, 1, 1, 39.90),
(1, 5, 2, 34.90),
(2, 10, 1, 89.90),
(3, 3, 1, 49.90),
(3, 9, 3, 29.90),
(4, 2, 1, 42.50),
(4, 6, 1, 44.00),
(5, 4, 1, 79.90),
(5, 8, 2, 36.50),
(6, 6, 1, 44.00),
(6, 7, 1, 38.00),
(7, 10, 1, 89.90),
(8, 9, 4, 29.90),
(8, 1, 1, 39.90),
(9, 10, 2, 89.90),
(9, 3, 1, 49.90),
(10, 5, 1, 34.90),
(10, 8, 1, 36.50);

-- Notas fiscais para pedidos faturados (não cancelados/pendentes); valor = soma dos itens
INSERT INTO notas_fiscais (id_pedido, numero, data_emissao, valor_total)
SELECT p.id_pedido,
       CONCAT('NF', LPAD(p.id_pedido, 6, '0')),
       p.data_pedido,
       SUM(i.quantidade * i.preco_unitario)
FROM pedidos p
JOIN itens_pedido i ON i.id_pedido = p.id_pedido
WHERE p.status IN ('Pago','Enviado','Entregue')
GROUP BY p.id_pedido, p.data_pedido;
