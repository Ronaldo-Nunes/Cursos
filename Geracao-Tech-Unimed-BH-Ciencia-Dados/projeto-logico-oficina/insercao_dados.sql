-- populando as tabelas do banco de dados com dados de teste
use oficina;

-- cliente(cliente_id, nome, tipo, email, telefone, cpf, cnpj)
insert into cliente(nome, tipo, email, telefone, cpf, cnpj)
	values ('Paulo Coelho', 'F', 'pau_co@gmail.com', '85999632523', 01232152856, null),
		   ('Marcos Paz', 'F', 'napaz@gmail.com', '85999632785', 01232155298, null),
           ('Maria Mota', 'F', 'marmota@gmail.com', '85995892523', 56982152856, null),
           ('Sonho Representações', 'J', 'sonho_rep@gmail.com', '85985632145', null, 23512356900012),
           ('Catatau Locadora', 'J', 'cataloc@gmail.com', '8545693215', null, 32145698230001);
           
select * from cliente;
           
-- mecanico(mecanico_id, nome, cpf, especialidade, logradouro, numero_logradouro, complemento, cidade, uf)
insert into mecanico(nome, cpf, especialidade, logradouro, numero_logradouro, complemento, cidade, uf)
	values ('João Pedro', 023658956, 'Mecânica de Motores', 'Rua das Algas', '256', null, 'Feira Grande', 'AL'),
		   ('Joana Marques', 896523014, 'Injeção Eletrônica', 'Rua Maria Angels', '25A', null, 'Arapiraca', 'AL'),
           ('Rafael Novais', 123956874, 'Suspenção', 'Av. Marques da Silva', '14', null, 'Arapiraca', 'AL'),
           ('Marcos Feijó', 023689546, 'Eletricista', 'Rua Manoel João', '35', null, 'Craíbas', 'AL'),
           ('José Cícero', 523680124, 'Mecânica geral', 'Rua Padre Cícero', '26B', null, 'Feira Grande', 'AL');
           
select * from mecanico;
           
-- veiculo(veiculo_id, placa, cliente_id, marca, modelo, ano_fabricacao, ano_modelo, cor)
insert into veiculo(placa, cliente_id, marca, modelo, ano_fabricacao, ano_modelo, cor)
	values ('HGN5G63', 1, 'GM', 'Celta', 1999, 1999, 'Preta'),
		   ('RDF4562', 2, 'FORD', 'Ranger', 2010, 2011, 'Prata'),
           ('RRE4J25', 3, 'FORD', 'Fiesta', 2019, 2020, 'Branca'),
           ('GRT8F25', 4, 'VW', 'Gol', 2010, 2011, 'Branca'),
           ('RKL8956', 5, 'VW', 'Polo', 2020, 2021, 'Branca');
           
select * from veiculo;
           
-- servico(servico_id, descricao, preco)
insert into servico(descricao, preco)
	values ('Alinhamento', 30.00),
		   ('Balanceamento', 30.00),
           ('Troca de fluido de freio', 70.00),
           ('Reparo suspensão', 100.00),
           ('Troca correia dentada', 80.00),
           ('Troca pastilhas de freio', 20.00),
           ('Limpeza de bicos injetores', 70.00),
           ('Limpeza sistema de arrefecimento', 80.00);
           
select * from servico;
           
-- peca(peca_id, descricao, preco)
insert into peca(descricao, preco)
	values ('Aditivo Radiador 1l', 10.00),
		   ('Radiador GM Celta 2010', 256.90),
           ('Óleo semi-sintetico 5w30', 28.00),
           ('Amortecedor diant Cofap unid', 220.00),
           ('Correia dentada GM', 50.00),
           ('Pastilhas de freio Corsa par', 80.00),
           ('Kit velas 1.0', 110.00),
           ('Cabos Vela 1.0', 100.00),
           ('Pneu 175/70-13 Pirelli', 250.00);
           
select * from peca;
           
-- ordem_servico(os_id int, veiculo_id, status_os - 'Análise','Autorizado','Executando','Concluído' -, data_emissao, data_previsao, data_conclusao)
insert into ordem_servico(veiculo_id, status_os, data_emissao, data_previsao, data_conclusao)
	values (1, 'Autorizado', '2022-12-11', '2022-12-13', null),
		   (2, 'Executando', '2022-12-11', '2022-12-12', null),
           (3, 'Análise', '2022-12-13', '2022-12-14', null),
           (4, 'Concluído', '2022-12-10', '2022-12-11', '2022-12-12'),
           (5, 'Análise', '2022-12-10', '2022-12-11', null);
           
select * from ordem_servico;
           
-- peca_item_os(peca_id, os_id, quantidade)
insert into peca_item_os(peca_id, os_id, quantidade)
	values (3, 1, 4),
		   (1, 2, 5),
           (2, 2, 1),
           (9, 3, 2),
           (5, 4, 1),
           (4, 5, 2),
           (6, 5, 1);
           
select * from peca_item_os;
           
-- servico_item_os(servico_id, os_id, quantidade)
insert into servico_item_os(servico_id, os_id, quantidade)
	values (8, 2, 1),
		   (1, 3, 1),
           (2, 3, 1),
           (5, 4, 1),
           (4, 5, 1);
           
select * from servico_item_os;
           
-- mecanico_os(mecanico_id, os_id)
insert into mecanico_os(mecanico_id, os_id)
	values (5, 1),
		   (3, 2),
           (4, 2),
           (5, 3),
           (1, 3),
           (2, 4),
           (5, 5),
           (3, 5);
           
select * from mecanico_os;        
           
