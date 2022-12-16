-- criação do banco de dados para oficina
create database oficina;

use oficina;

-- criação da tabela de clientes
create table cliente(
	cliente_id int unsigned auto_increment primary key,
    nome varchar(80) not null,
    tipo enum('F','J') not null,
    email varchar(50),
    telefone varchar(12) not null,
    cpf char(11) unique,
    cnpj char(14) unique,
    check(tipo in ('F', 'J')),
    check((tipo = 'F' and cpf is not null) or (tipo <> 'F' and cpf is null)),
	check((tipo = 'J' and cnpj is not null) or (tipo <> 'J' and cnpj is null))
);

-- criação da tabela de mecânicos
create table mecanico(
	mecanico_id int unsigned auto_increment primary key,
    nome varchar(80) not null,
    cpf char(11) not null unique,
    especialidade varchar(30) not null,
    logradouro varchar(100) not null,
    numero_logradouro varchar(8) not null,
    complemento varchar(60),
    cidade varchar(80) not null,
    uf char(2) not null    
);

-- criação da tabela de veículos
create table veiculo(
	veiculo_id int unsigned auto_increment primary key,
    placa char(7) not null unique,
    cliente_id int unsigned not null,
    marca varchar(20) not null,
    modelo varchar(15) not null,
    ano_fabricacao char(4) not null,
    ano_modelo char(4) not null,
    cor varchar(10) not null,
    constraint fk_cliente_veiculo foreign key (cliente_id) references cliente(cliente_id)
);

-- criação da tabela peças
create table servico(
	servico_id int unsigned auto_increment primary key,
    descricao varchar(150) not null,
    preco float not null
);

-- criação da tabela peças
create table peca(
	peca_id int unsigned auto_increment primary key,
    descricao varchar(150) not null,
    preco float not null
);

-- criação da tabela ordem de serviço
create table ordem_servico(
	os_id int unsigned auto_increment primary key,
    veiculo_id int unsigned not null,
    status_os enum('Análise','Autorizado','Executando','Concluído') default 'Análise',
    data_emissao date not null,
    data_previsao date not null,
    data_conclusao date,
    constraint fk_veiculo_os foreign key (veiculo_id) references veiculo(veiculo_id)
);

-- criação da tabela de itens - peças - da ordem de serviço
create table peca_item_os(
	peca_id int unsigned not null,
    os_id int unsigned not null,
    quantidade int not null,
    primary key(peca_id, os_id),
    constraint fk_peca_ordem_servico foreign key (peca_id) references peca(peca_id),
    constraint fk_ordem_servico_peca foreign key (os_id) references ordem_servico(os_id)
);

-- criação da tabela de itens - serviços - da ordem de serviço
create table servico_item_os(
	servico_id int unsigned not null,
    os_id int unsigned not null,
    quantidade int not null,
    primary key(servico_id, os_id),
    constraint fk_servico_ordem_serv foreign key (servico_id) references servico(servico_id),
    constraint fk_ordem_serv_servico foreign key (os_id) references ordem_servico(os_id)
);

-- criação da tabela de mecânicos responsáveis pela OS
create table mecanico_os(
	mecanico_id int unsigned not null,
    os_id int unsigned not null,
    primary key(mecanico_id, os_id),
    constraint fk_mecanico_ordem_servico foreign key (mecanico_id) references mecanico(mecanico_id),
    constraint fk_ordem_servico_mecanico foreign key (os_id) references ordem_servico(os_id)
);



