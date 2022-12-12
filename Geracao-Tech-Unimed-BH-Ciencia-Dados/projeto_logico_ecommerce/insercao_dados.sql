-- inserção de dados
use ecommerce;

-- cep(num_cep, tipo_logradouro, nome_logradouro, municipio, estado)
insert into cep (num_cep, tipo_logradouro, nome_logradouro, municipio, estado)
	values (12345678, 'Rua', 'Rua Pitanga', 'Cuiabá', 'Mato Grosso'),
		   (23568977, 'Avenida', 'Av. Paulista', 'São Paulo', 'São Paulo'),
           (32156987, 'Rodovia', 'Rod. BR 101 KM 200', 'Maceió', 'Alagoas'),
           (57300200, 'Avenida', 'Av. Rio Branco', 'Arapiraca', 'Alagoas'),
           (87456987, 'Rua', 'Rua Ipê Branco', 'Caruaru', 'Pernambuco'),
           (36595874, 'Rua', 'Rua das Flores', 'Fortaleza', 'Ceará'),
           (23514582, 'Praça', 'Praça Santa Ana', 'Manaus', 'Amazonas');
           
select * from cep;

-- cliente(cliente_id, num_cep, nome, tipo enum('F','J'), data_nascimento, email, telefone, cpf, cnpj, numero_logradouro)
insert into cliente(num_cep, nome, tipo, data_nascimento, email, telefone, cpf, cnpj, numero_logradouro)
	values (87456987, 'João dos Santos', 'F', '1998-02-10', 'poter@gmail.com', 85992655635, 12345678956, null, '256A'),
		   (36595874, 'Casão Delivery', 'J', null, 'fortecomp@gmail.com', 21369547895, null, 32145678930001, '245'),
           (57300200, 'Marcela Silva', 'F', '1987-05-15', 'calango@gmail.com', '82981254685', 36978954621, null, '12'),
           (12345678, 'Ágata Barbosa', 'F', '1986-03-12', 'teteu@hotmail.com', '15996872532', 25898745632, null, '25'),
           (23514582, 'Marcelo Fernandes', 'F', '1990-12-30', 'lugano@outlook.com', '23961253689', 96578512546, null, '61'),
           (32156987, 'Roberto Marinho', 'F', '1982-10-12', 'betomar@gmail.com', '61995623541', 12545215936, null, '55');
           
select * from cliente;

-- fornecedor(fornecedor_id, num_cep, razao_social, nome_fantasia, cnpj, telefone, email, numero_logradouro)
insert into fornecedor(num_cep, razao_social, nome_fantasia, cnpj, telefone, email, numero_logradouro)
	values (12345678, 'Eletronicos Silva', null, 32156896510002, '563215252', 'eletrosilva@gmail.com', '23'),
		   (23568977, 'Almeida e Barbosa', null, 52365484530003, '2564552365', 'aeb@gmail.com', '25B'),
           (23514582, 'Manufatura Oliveira do Brasil', 'Manobras', 25696878410001, '6365489685', 'manobras@hotmail.com', '258');
           
select * from fornecedor;

-- vendedor_parceiro(vendedor_parc_id, num_cep, razao_social, tipo_vendedor, telefone, email, cpf, cnpj, numero_logradouro)
insert into vendedor_parceiro(num_cep, razao_social, tipo_vendedor, telefone, email, cpf, cnpj, numero_logradouro)
	values (36595874, 'Wanda Silva', 'F', '85966235441', 'wans@gmail.com', 32568912578, null, '65'),
		   (23514582, 'Manufatura Oliveira do Brasil', 'J', '6365489685', 'manobras@hotmail.com', null, 25696878410001, '258'),
           (87456987, 'Matheus Aguiar', 'F', '6532142586', 'maheusag@hotmail.com', 23569845222, null, '23');
           
select * from vendedor_parceiro;

-- estoque(estoque_id, num_cep, numero_logradouro, descricao)
insert into estoque(num_cep, numero_logradouro, descricao)
	values (36595874, '356', 'Estoque Nordeste'),
		   (12345678, '125B', 'Estoque Centro-oeste'),
           (23568977, '1254', 'Estoque São Paulo');
           
select * from estoque;

-- categoria_produto(categoria_prod_id, descricao, ativa)
insert into categoria_produto(descricao)
	values ('Eletrônicos'),
		   ('Ferramentas'),
           ('Eletrodomésticos'),
           ('Utilidades'),
           ('Brinquedos'),
           ('Móveis');

select * from categoria_produto;

-- produto(produto_id, categoria_prod_id, descricao, marca, cor, valor, infantil, ativo, tamanho, informacoes, ficha_tecnica)
insert into produto(categoria_prod_id, descricao, marca, cor, valor, infantil, ativo, tamanho, informacoes, ficha_tecnica)
	values (1, 'Fone-de-ouvido', 'Sonn', 'Branco', 57.85, false, true, 'Único', null, null),
		   (5, 'Barbie Elsa', 'Mattel', null, 120.99, true, true, null, null, null),
           (6, 'Sofá retrátil', 'Madesil', 'Bege', 1299.99, false, true, null, null, null),
           (2, 'Furadeira 200W', 'Famastil', 'Preta', 159.90, false, true, null, null, null),
           (3, 'Geladeira Frost-free', 'Dako', 'Branca', 1290.99, false, true, null, null, null);
           
select * from produto;

-- fornecedor_produto(fornecedor_id, produto_id)
insert into fornecedor_produto(fornecedor_id, produto_id)
	values (1, 3), 
		   (2, 4), 
           (2, 1), 
           (3, 3), 
           (3, 2);

select * from fornecedor_produto;

-- vendedor_produto(vendedor_parc_id, produto_id, quantidade)
insert into vendedor_produto(vendedor_parc_id, produto_id, quantidade)
	values (1, 5, 10),
		   (2, 3, 20),
           (3, 2, 10);
           
select * from vendedor_produto;

-- estoque_produto(estoque_id, produto_id, quantidade)
insert into estoque_produto(estoque_id, produto_id, quantidade)
	values (1, 2, 30),
		   (2, 3, 20),
           (3, 4, 15),
           (3, 1, 10),
           (2, 2, 10);
           
select * from estoque_produto;

-- avaliacao_produto(avaliacao_id, produto_id, cliente_id, data_avaliacao, nota, resenha)
insert into avaliacao_produto(produto_id, cliente_id, data_avaliacao, nota, resenha)
	values (5, 1, '2022-06-10', 2, null),
		   (3, 4, '2022-07-06', 4, null),
           (1, 2, '2022-07-10', 3, null);
           
select * from avaliacao_produto;

-- forma_pagamento(forma_pagamento_id, descricao)
insert into forma_pagamento(descricao)
	values ('Cartão de crédito'), 
		   ('PIX'),
           ('Boleto'),
           ('Dois cartões');

select * from forma_pagamento;

-- pedido(pedido_id, cliente_id, data_realizacao, valor_frete, descricao, codigo_rastreio)
insert into pedido(cliente_id, data_realizacao, valor_frete, descricao, codigo_rastreio)
	values (1, '2022-05-10', 45.75, 'compra aplicativo', 'NT2563DFG4BR'),
		   (2, '2022-04-07', 20.10, 'compra web site', null),
           (4, '2022-05-12', 35.70, 'compra web site', 'NF256NFH44BR'),
           (2, '2022-06-10', 56.7, 'compra aplicativo', 'FR45854SD2BR'),
           (3, '2022-07-21', null, 'compra web site', null);
           
select * from pedido;

-- item_pedido(pedido_id, produto_id, quantidade, desconto)
insert into item_pedido(pedido_id, produto_id, quantidade, desconto)
	values (1, 2, 2, 0),
		   (1, 5, 1, 0),
           (2, 3, 1, 0),
           (3, 4, 1, 0),
           (3, 1, 1, 0),
           (4, 2, 1, 0),
           (4, 1, 2, 0),
           (5, 5, 1, 0);
           
select * from item_pedido;

-- pagamento(forma_pagamento_id, pedido_id, cliente_id, data_efetivacao, condicoes)
insert into pagamento(forma_pagamento_id, pedido_id, cliente_id, data_efetivacao, condicoes)
	values (1, 1, 1, '2022-05-10', null),
		   (2, 2, 2, '2022-04-07', null),
           (1, 3, 4, '2022-05-13', null),
           (1, 4, 2, '2022-06-10', null),
           (2, 5, 3, '2022-07-21', null);
           
select * from pagamento;

-- status_pedido(codigo, pedido_id, data_atualizacao)
#0 - em-andamento
#1 - cancelado
#2 - realizado
#3 - nf-emitida
#4 - separando
#5 - transportando
#6 - entregue
insert into status_pedido(codigo, pedido_id, data_atualizacao)
	values (2, 1, '2022-05-10'),
		   (3, 1, '2022-05-12'),
           (4, 2, '2022-04-10'),
           (5, 2, '2022-04-12'),
           (2, 3, '2022-05-13'),
           (3, 4, '2022-06-11'),
           (6, 5, '2022-07-23');
           
select * from status_pedido;
           
           
           
    