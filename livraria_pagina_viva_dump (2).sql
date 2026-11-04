create database livraria_pagina_viva;
use livraria_pagina_viva;
set foreign_key_checks=0;
create table autores (
  id_autor int(11) not null auto_increment,
  nome varchar(100) not null,
  nacionalidade varchar(50) not null,
  primary key (id_autor)
);
insert into autores values
(1,'Machado de Assis','Brasileira'),
(2,'Jorge Amado','Brasileira'),
(3,'João Guimarães Rosa','Brasileira'),
(4,'Clarice Lispector','Brasileira'),
(5,'Carlos Drummond de Andrade','Brasileira'),
(6,'Cecília Meireles','Brasileira'),
(7,'Ariano Suassuna','Brasileira'),
(8,'Monteiro Lobato','Brasileira'),
(9,'Ana Ribeiro','Brasileira'),
(10,'Carlos Menezes','Portuguesa');
create table categorias (
  id_categoria int(11) not null auto_increment,
  nome varchar(60) not null,
  primary key (id_categoria),
  unique key nome (nome)
);
insert into categorias values
(6,'Didático'),
(4,'Infantil'),
(2,'Poesia'),
(1,'Romance'),
(3,'Teatro'),
(5,'Tecnologia');
create table cliente_interesses (
  id_cliente int(11) not null,
  id_categoria int(11) not null,
  primary key (id_cliente,id_categoria),
  key id_categoria (id_categoria),
  constraint cliente_interesses_ibfk_1 foreign key (id_cliente) references clientes (id_cliente),
  constraint cliente_interesses_ibfk_2 foreign key (id_categoria) references categorias (id_categoria)
);
insert into cliente_interesses values
(1,1),
(1,2),
(2,5),
(3,1),
(4,3),
(5,2),
(6,5),
(7,4),
(8,5);
create table cliente_telefones (
  id_telefone int(11) not null auto_increment,
  id_cliente int(11) not null,
  numero varchar(15) not null,
  tipo enum('celular','residencial','comercial') not null,
  primary key (id_telefone),
  key id_cliente (id_cliente),
  constraint cliente_telefones_ibfk_1 foreign key (id_cliente) references clientes (id_cliente)
);
insert into cliente_telefones values
(1,1,'(11) 98888-1111','celular'),
(2,1,'(11) 3333-1111','residencial'),
(3,2,'(21) 97777-2222','celular'),
(4,3,'(31) 96666-3333','celular'),
(5,4,'(71) 95555-4444','celular'),
(6,5,'(51) 94444-5555','celular'),
(7,6,'(81) 93333-6666','celular'),
(8,7,'(11) 2222-7777','comercial'),
(9,8,'(41) 92222-8888','celular');
create table clientes (
  id_cliente int(11) not null auto_increment,
  nome varchar(100) not null,
  email varchar(120) not null,
  cpf char(11) not null,
  cidade varchar(60) not null,
  uf char(2) not null,
  data_cadastro date not null,
  primary key (id_cliente),
  unique key email (email),
  unique key cpf (cpf)
);
insert into clientes values
(1,'Mariana Souza','mariana.souza@gmail.com','11111111111','São Paulo','SP','2025-03-10'),
(2,'Pedro Almeida','pedro.almeida@outlook.com','22222222222','Rio de Janeiro','RJ','2025-05-22'),
(3,'Juliana Costa','juliana.costa@gmail.com','33333333333','Belo Horizonte','MG','2025-08-14'),
(4,'Rafael Lima','rafael.lima@yahoo.com','44444444444','Salvador','BA','2025-11-02'),
(5,'Camila Ferreira','camila.ferreira@gmail.com','55555555555','Porto Alegre','RS','2026-01-18'),
(6,'Lucas Martins','lucas.martins@hotmail.com','66666666666','Recife','PE','2026-02-27'),
(7,'Fernanda Rocha','fernanda.rocha@gmail.com','77777777777','São Paulo','SP','2026-04-05'),
(8,'Bruno Carvalho','bruno.carvalho@outlook.com','88888888888','Curitiba','PR','2026-06-30');
create table editoras (
  id_editora int(11) not null auto_increment,
  nome varchar(100) not null,
  cidade varchar(60) not null,
  uf char(2) not null,
  primary key (id_editora)
);
insert into editoras values
(1,'Editora Horizonte','São Paulo','SP'),
(2,'Letras do Sul','Porto Alegre','RS'),
(3,'Casa do Sertão','Salvador','BA'),
(4,'Ponte Nova','Belo Horizonte','MG'),
(5,'Tecnoprint','Recife','PE');
create table itens_pedido (
  id_pedido int(11) not null,
  id_livro int(11) not null,
  quantidade int(11) not null check (quantidade > 0),
  preco_unitario decimal(8,2) not null,
  primary key (id_pedido,id_livro),
  key id_livro (id_livro),
  constraint itens_pedido_ibfk_1 foreign key (id_pedido) references pedidos (id_pedido),
  constraint itens_pedido_ibfk_2 foreign key (id_livro) references livros (id_livro)
);
insert into itens_pedido values
(1,1,1,39.90),
(1,5,2,34.90),
(2,10,1,89.90),
(3,3,1,49.90),
(3,9,3,29.90),
(4,2,1,42.50),
(4,6,1,44.00),
(5,4,1,79.90),
(5,8,2,36.50),
(6,6,1,44.00),
(6,7,1,38.00),
(7,10,1,89.90),
(8,1,1,39.90),
(8,9,4,29.90),
(9,3,1,49.90),
(9,10,2,89.90),
(10,5,1,34.90),
(10,8,1,36.50);
create table livro_autor (
  id_livro int(11) not null,
  id_autor int(11) not null,
  primary key (id_livro,id_autor),
  key id_autor (id_autor),
  constraint livro_autor_ibfk_1 foreign key (id_livro) references livros (id_livro),
  constraint livro_autor_ibfk_2 foreign key (id_autor) references autores (id_autor)
);
insert into livro_autor values
(1,1),
(2,1),
(3,2),
(4,3),
(5,4),
(6,5),
(7,6),
(8,7),
(9,8),
(10,9),
(10,10);
create table livros (
  id_livro int(11) not null auto_increment,
  titulo varchar(150) not null,
  isbn char(13) not null,
  ano_publicacao smallint(6) not null,
  preco decimal(8,2) not null check (preco > 0),
  estoque int(11) not null default 0 check (estoque >= 0),
  id_editora int(11) not null,
  id_categoria int(11) not null,
  primary key (id_livro),
  unique key isbn (isbn),
  key id_editora (id_editora),
  key id_categoria (id_categoria),
  constraint livros_ibfk_1 foreign key (id_editora) references editoras (id_editora),
  constraint livros_ibfk_2 foreign key (id_categoria) references categorias (id_categoria)
);
insert into livros values
(1,'Dom Casmurro','9780000000011',1899,39.90,25,1,1),
(2,'Memórias Póstumas de Brás Cubas','9780000000028',1881,42.50,18,1,1),
(3,'Capitães da Areia','9780000000035',1937,49.90,30,3,1),
(4,'Grande Sertão: Veredas','9780000000042',1956,79.90,8,3,1),
(5,'A Hora da Estrela','9780000000059',1977,34.90,22,2,1),
(6,'Antologia Poética','9780000000066',1962,44.00,12,4,2),
(7,'Romanceiro da Inconfidência','9780000000073',1953,38.00,6,4,2),
(8,'Auto da Compadecida','9780000000080',1955,36.50,15,2,3),
(9,'Reinações de Narizinho','9780000000097',1931,29.90,40,1,4),
(10,'Banco de Dados na Prática','9780000000103',2021,89.90,10,5,5);
create table notas_fiscais (
  id_nota int(11) not null auto_increment,
  id_pedido int(11) not null,
  numero varchar(10) not null,
  data_emissao date not null,
  valor_total decimal(10,2) not null,
  primary key (id_nota),
  unique key id_pedido (id_pedido),
  unique key numero (numero),
  constraint notas_fiscais_ibfk_1 foreign key (id_pedido) references pedidos (id_pedido)
);
insert into notas_fiscais values
(1,1,'NF000001','2026-01-12',109.70),
(2,2,'NF000002','2026-02-03',89.90),
(3,3,'NF000003','2026-02-20',139.60),
(4,4,'NF000004','2026-03-15',86.50),
(5,5,'NF000005','2026-04-08',152.90),
(6,6,'NF000006','2026-05-19',82.00),
(7,8,'NF000008','2026-07-21',159.50),
(8,9,'NF000009','2026-09-14',229.70);
create table pedidos (
  id_pedido int(11) not null auto_increment,
  id_cliente int(11) not null,
  data_pedido date not null,
  status enum('Pendente','Pago','Enviado','Entregue','Cancelado') not null default 'Pendente',
  forma_pagamento enum('Pix','Cartão de crédito','Boleto') not null,
  primary key (id_pedido),
  key id_cliente (id_cliente),
  constraint pedidos_ibfk_1 foreign key (id_cliente) references clientes (id_cliente)
);
insert into pedidos values
(1,1,'2026-01-12','Entregue','Pix'),
(2,2,'2026-02-03','Entregue','Cartão de crédito'),
(3,3,'2026-02-20','Entregue','Boleto'),
(4,1,'2026-03-15','Entregue','Cartão de crédito'),
(5,4,'2026-04-08','Enviado','Pix'),
(6,5,'2026-05-19','Pago','Pix'),
(7,6,'2026-06-02','Cancelado','Boleto'),
(8,7,'2026-07-21','Enviado','Cartão de crédito'),
(9,2,'2026-09-14','Pago','Pix'),
(10,8,'2026-10-30','Pendente','Boleto');
set foreign_key_checks=1;
