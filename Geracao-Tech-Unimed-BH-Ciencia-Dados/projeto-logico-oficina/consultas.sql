-- consultas ao banco de dados

use oficina;

-- listagem de todos os clientes
select * from cliente;

-- listagem de clientes pessoa física
select cliente_id, nome, email, telefone, cpf from cliente where tipo = 'F';

-- listagem de clientes pessoa jurídica
select cliente_id, nome, email, telefone, cnpj from cliente where tipo = 'J';

-- listagem de veículos por cliente
select nome as cliente, tipo, if(cpf is null, cnpj, cpf) as documento, telefone, placa, modelo, cor
	from cliente inner join veiculo using(cliente_id);
    
-- contagem de serviços realizados em cada veiculo
select v.placa, sum(ios.quantidade) as qtd_servicos
	from ordem_servico as os inner join veiculo as v using(veiculo_id)
    inner join servico_item_os as ios using(os_id)
    group by placa;
    
-- contagem de serviços realizados por cliente
select nome as cliente, qtd_servicos
	from cliente inner join (
		select v.cliente_id, v.placa, sum(ios.quantidade) as qtd_servicos
			from ordem_servico as os inner join veiculo as v using(veiculo_id)
			inner join servico_item_os as ios using(os_id)
			group by placa
    ) as servicos_veiculos using(cliente_id)
    order by qtd_servicos desc;
    
-- listagem dos mecanicos
select * from mecanico;

-- listagem dos mecanicos por ordem de serviço
select ms.os_id as ordem_servico, m.nome as mecanico
	from mecanico as m inner join mecanico_os as ms using(mecanico_id)
    order by mecanico;
    
-- contagem de ordens de serviço em execução em que cada mecânico está trabalhando
select m.nome as mecanico, count(ms.os_id) as ordens_servico
	from mecanico as m inner join mecanico_os as ms using(mecanico_id)
    inner join ordem_servico as os using(os_id)
    where os.status_os = 'Executando'
    group by mecanico;
    
-- contagem de ordens de serviço em que cada mecânico consta como responsável
select m.nome as mecanico, count(ms.os_id) as ordens_servico
	from mecanico as m inner join mecanico_os as ms using(mecanico_id)
    inner join ordem_servico as os using(os_id)
    group by mecanico;
    
-- contagem de ordens de serviço por veiculo
select placa as veiculo, count(os_id) qtd_os
	from ordem_servico inner join veiculo using(veiculo_id)
    group by placa
    order by qtd_os desc;
    
-- listagem de serviços
select * from servico;

-- listagem de peças
select * from peca;

-- exibir valor das ordens de serviço por veículo
select os_id, sum(preco * quantidade) as valor from servico inner join servico_item_os using(servico_id) group by os_id order by os_id;
select os_id, sum(preco * quantidade) as valor from peca inner join peca_item_os using(peca_id) group by os_id order by os_id;

select placa as veiculo, os_id as os, 
	round(if(total_pecas.valor is null, 0, total_pecas.valor) + if(total_servicos.valor is null, 0, total_servicos.valor), 2) as total
	from ordem_servico inner join veiculo using(veiculo_id)
    left join (select os_id, sum(preco * quantidade) as valor from peca inner join peca_item_os using(peca_id) group by os_id) as total_pecas using(os_id)
    left join (select os_id, sum(preco * quantidade) as valor from servico inner join servico_item_os using(servico_id) group by os_id) as total_servicos using(os_id)
    group by os_id;
    
-- lista de ordens de serviço
select os.os_id, os.data_emissao, os.status_os, if(os.data_previsao < curdate() and os.status_os in ('Autorizado', 'Executando'), 'Em atraso', 'No prazo') as situacao,
	c.nome as cliente, concat(v.marca, '/ ', v.modelo, ' cor ', v.cor, ' ', v.ano_fabricacao, ' placa: ', v.placa) as veiculo
	from veiculo as v inner join cliente as c using(cliente_id)
    inner join ordem_servico as os using(veiculo_id);
    
-- lista de peças e serviços de uma ordem de serviço
select os.os_id, codigo, descricao, valor_unitario, quantidade, total_item
	from ordem_servico as os
    inner join (select pci.os_id, p.peca_id as codigo, p.descricao, p.preco as valor_unitario, pci.quantidade, round((p.preco * pci.quantidade), 2) as total_item
					from peca as p inner join peca_item_os as pci using(peca_id)
					union
				select si.os_id, s.servico_id as codigo, s.descricao, s.preco as valor_unitario, si.quantidade, round((s.preco * si.quantidade), 2) as total_item
					from servico as s inner join servico_item_os as si using(servico_id)
				) as itens_os using(os_id)
    where os.os_id = 5;
        
