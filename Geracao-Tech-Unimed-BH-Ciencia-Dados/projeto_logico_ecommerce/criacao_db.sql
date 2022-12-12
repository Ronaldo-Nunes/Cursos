-- criação do banco de dados de Ecommerce
create database ecommerce;
use ecommerce;

-- criação da tabela CEP
create table cep(
	num_cep char(8) primary key,
    tipo_logradouro varchar(20) not null,
    nome_logradouro varchar(150) not null,
    municipio varchar(80) not null,
    estado varchar(80) not null
); 
desc cep;

-- criação da tabela de clientes
create table cliente(
	cliente_id int unsigned auto_increment primary key,
    num_cep char(8) not null,
    nome varchar(100) not null,
    tipo enum('F','J') not null,
    data_nascimento date,
    email varchar(50) not null,
    telefone varchar(12) not null,
    cpf char(11) unique,
    cnpj char(14) unique,
    numero_logradouro varchar(8),
    constraint fk_cep_cliente foreign key (num_cep) references cep(num_cep), 
    check(tipo in ('F', 'J')),
    check((tipo = 'F' and cpf is not null and data_nascimento is not null) or (tipo <> 'F' and cpf is null and data_nascimento is null)),
	check((tipo = 'J' and cnpj is not null) or (tipo <> 'J' and cnpj is null))
);

-- criação da tabela fornecedor
create table fornecedor(
	fornecedor_id int unsigned auto_increment primary key,
    num_cep char(8) not null,
    razao_social varchar(50) not null,
    nome_fantasia varchar(50),
    cnpj char(14) not null unique,
    telefone varchar(12) not null,
    email varchar(50),
    numero_logradouro varchar(8),
    constraint fk_cep_fornecedor foreign key (num_cep) references cep(num_cep)
);

-- criação da tabela de vendedor_parceiro
create table vendedor_parceiro(
	vendedor_parc_id int unsigned auto_increment primary key,
    num_cep char(8) not null,
    razao_social varchar(80) not null,
    tipo_vendedor enum('F','J') not null,
    telefone varchar(12) not null,
    email varchar(50) not null,
    cpf char(11) unique,
    cnpj char(14) unique,
    numero_logradouro varchar(8),
    constraint fk_cep_vendedor_parc foreign key (num_cep) references cep(num_cep), 
    check(tipo_vendedor in ('F', 'J')),
    check((tipo_vendedor = 'F' and cpf is not null) or (tipo_vendedor <> 'F' and cpf is null)),
	check((tipo_vendedor = 'J' and cnpj is not null) or (tipo_vendedor <> 'J' and cnpj is null))
);

-- criação da tabela estoque
create table estoque(
	estoque_id int unsigned primary key auto_increment,
    num_cep char(8) not null,
    numero_logradouro varchar(8) not null,
    descricao varchar(45),
    constraint fk_cep_estoque foreign key (num_cep) references cep(num_cep)
);

-- criação da tabela categoria_produto
create table categoria_produto(
	categoria_prod_id int unsigned auto_increment primary key,
    descricao varchar(30) not null,
    ativa boolean default true
);

-- criação da tabela produto
create table produto(
	produto_id int unsigned auto_increment primary key,
    categoria_prod_id int unsigned not null,
    descricao varchar(60) not null,
    marca varchar(30) not null,
    cor varchar(12),
    valor float not null,
    infantil boolean default false,
    ativo boolean default true,
    tamanho varchar(20),
    informacoes varchar(600),
    ficha_tecnica varchar(400),
    constraint fk_categoria_produto foreign key (categoria_prod_id) references categoria_produto(categoria_prod_id)
);

-- criação da tabela fornecedor_produto
create table fornecedor_produto(
	fornecedor_id int unsigned not null,
    produto_id int unsigned not null,
    primary key (fornecedor_id, produto_id),
    constraint fk_fornecedor_produto foreign key (fornecedor_id) references fornecedor(fornecedor_id),
    constraint fk_produto_fornecedor foreign key (produto_id) references produto(produto_id)
);

-- criação da tabela vendedor_produto
create table vendedor_produto(
	vendedor_parc_id int unsigned not null,
    produto_id int unsigned not null,
    quantidade int unsigned not null,
    primary key (vendedor_parc_id, produto_id),
    constraint fk_vendedor_parc_produto foreign key (vendedor_parc_id) references vendedor_parceiro(vendedor_parc_id),
    constraint fk_produto_vendedor_parc foreign key (produto_id) references produto(produto_id)
);

-- criação da tabela estoque_produto
create table estoque_produto(
	estoque_id int unsigned not null,
    produto_id int unsigned not null,
    quantidade int unsigned not null,
    primary key (estoque_id, produto_id),
    constraint fk_estoque_produto foreign key (estoque_id) references estoque(estoque_id),
    constraint fk_produto_estoque foreign key (produto_id) references produto(produto_id)
);

-- criação da tabela avaliacao_produto
create table avaliacao_produto(
	avaliacao_id int unsigned auto_increment primary key,
    produto_id int unsigned not null,
    cliente_id int unsigned not null,
    data_avaliacao date not null,
    nota tinyint default 0,
    resenha varchar(200),
    check(nota in (0,1,2,3,4,5)),
    constraint fk_produto_avaliacao foreign key (produto_id) references produto(produto_id),
    constraint fk_cliente_avaliacao foreign key (cliente_id) references cliente(cliente_id)
);

-- criação da tabela forma_pagamento
create table forma_pagamento(
	forma_pagamento_id int unsigned auto_increment primary key,
    descricao varchar(20) not null
);

-- criação da tabela pedido
create table pedido(
	pedido_id int unsigned auto_increment primary key,
    cliente_id int unsigned not null,
    data_realizacao date not null,
    valor_frete float,
    descricao varchar(20),
    codigo_rastreio varchar(20),
    constraint fk_cliente_pedido foreign key (cliente_id) references cliente(cliente_id) on update cascade
);

-- criação da tabela item_pedido
create table item_pedido(
	pedido_id int unsigned not null,
    produto_id int unsigned not null,
    quantidade int unsigned not null,
    desconto float default 0,
    primary key (pedido_id, produto_id),
    constraint fk_pedido_item_pedido foreign key (pedido_id) references pedido(pedido_id),
    constraint fk_produto_item_pedido foreign key (produto_id) references produto(produto_id)
);

-- criação da tabela pagamento
create table pagamento(
	forma_pagamento_id int unsigned not null,
    pedido_id int unsigned not null,
    cliente_id int unsigned not null,
    data_efetivacao date not null,
    condicoes varchar(30),
    primary key (forma_pagamento_id, pedido_id, cliente_id),
    constraint fk_forma_pag_pagamento foreign key (forma_pagamento_id) references forma_pagamento(forma_pagamento_id),
    constraint fk_pedido_pagamento foreign key (pedido_id) references pedido(pedido_id),
    constraint fk_cliente_pagamento foreign key (cliente_id) references cliente(cliente_id)
);

-- criação da tabela status_pedido
-- códigos
#0 - em-andamento
#1 - cancelado
#2 - realizado
#3 - nf-emitida
#4 - separando
#5 - transportando
#6 - entregue
create table status_pedido(
	codigo int default 0,
    pedido_id int unsigned not null,
    data_atualizacao date not null,
    primary key (codigo, pedido_id),
    constraint fk_pedido_status_pedido foreign key (pedido_id) references pedido(pedido_id)
);

show tables;

