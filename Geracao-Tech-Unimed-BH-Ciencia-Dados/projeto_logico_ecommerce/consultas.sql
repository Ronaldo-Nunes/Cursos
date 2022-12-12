-- consultas
use ecommerce;

-- Quantos pedidos foram feitos por cada cliente?
select c.nome as cliente, count(p.pedido_id) as pedidos
	from cliente as c left join pedido as p on c.cliente_id = p.cliente_id
    group by c.cliente_id
    order by pedidos desc;
    
-- Clientes com mais de 1 pedido
select c.nome as cliente, count(p.pedido_id) as pedidos
	from cliente as c inner join pedido as p on c.cliente_id = p.cliente_id
    group by c.cliente_id
    having pedidos > 1
    order by pedidos desc;
    
-- detalhes do pedido
select p.pedido_id, p.data_realizacao, p.valor_frete, p.descricao,
	round((sum(pd.valor * ip.quantidade) + if(p.valor_frete is null, 0, p.valor_frete)), 2) as total_pedido,
    fp.descricao as forma_pagamento, pg.data_efetivacao as data_pagamento,
	case when sp.codigo = 0 then 'Em andamento'
        when sp.codigo = 1 then 'Cancelado'
        when sp.codigo = 2 then 'Realizado'
        when sp.codigo = 3 then 'NF emitida'
        when sp.codigo = 4 then 'Separando'
        when sp.codigo = 5 then 'Em transporte'
        when sp.codigo = 6 then 'Entregue'
        else '<desconhecido>'
    end as status,
    sp.data_atualizacao as ultima_atualizacao
	from pedido as p inner join item_pedido as ip on p.pedido_id = ip.pedido_id
    inner join produto as pd on pd.produto_id = ip.produto_id
    inner join status_pedido as sp on sp.pedido_id = p.pedido_id
    inner join pagamento as pg on pg.pedido_id = p.pedido_id
    inner join forma_pagamento as fp on fp.forma_pagamento_id = pg.forma_pagamento_id
    where p.pedido_id = 5;
    
-- itens de um pedido
select p.pedido_id, pd.descricao as produtos, ip.quantidade
	from pedido as p inner join item_pedido as ip on p.pedido_id = ip.pedido_id
    inner join produto as pd on pd.produto_id = ip.produto_id
    where p.pedido_id = 1;

-- Algum vendedor também é fornecedor?
select vp.cnpj, vp.razao_social, f.nome_fantasia, cep.municipio, cep.estado
	from vendedor_parceiro as vp inner join fornecedor as f on vp.cnpj = f.cnpj
    inner join cep on vp.num_cep = cep.num_cep;

-- Relação de produtos, fornecedores e estoques;
select e.descricao as estoque, cep.municipio, cep.estado, p.descricao as produto, ep.quantidade, if(quantidade>10, "Normal", "Baixo") as nivel_estoque, f.razao_social as fornecedor
	from estoque as e inner join cep on e.num_cep = cep.num_cep
    inner join estoque_produto as ep on ep.estoque_id = e.estoque_id
    inner join produto as p on p.produto_id = ep.produto_id
    inner join fornecedor_produto as fp on fp.produto_id = p.produto_id
    inner join fornecedor as f on f.fornecedor_id = fp.fornecedor_id;

-- Relação de produtos;
select p.produto_id, p.descricao, cp.descricao as categoria, p.marca, p.cor, p.valor
	from produto as p inner join categoria_produto as cp 
    on p.categoria_prod_id = cp.categoria_prod_id;

-- Relação de fornecedores;
select * from fornecedor;

-- Relação de vendedores parceiros
select * from vendedor_parceiro;

-- quantidade de produtos disponibilizados por cada vendedor
select v.razao_social as fornecedor, p.descricao as produto, vp.quantidade
	from vendedor_parceiro as v inner join vendedor_produto as vp on v.vendedor_parc_id = vp.vendedor_parc_id
    inner join produto as p on p.produto_id = vp.produto_id;

-- Relação de estoques;
select estoque_id as codigo, descricao as estoque, municipio, estado
	from estoque inner join cep on estoque.num_cep = cep.num_cep;

-- Relação de nomes dos fornecedores e nomes dos produtos;
select f.razao_social as fornecedor, p.descricao as produto
	from fornecedor as f inner join fornecedor_produto as fp on f.fornecedor_id = fp.fornecedor_id
    inner join produto as p on fp.produto_id = p.produto_id
    union
select v.razao_social as fornecedor, p.descricao as produto
	from vendedor_parceiro as v inner join vendedor_produto as vp on v.vendedor_parc_id = vp.vendedor_parc_id
    inner join produto as p on p.produto_id = vp.produto_id;

-- recuperando o histórico de atualização de status dos pedidos
select p.pedido_id, p.descricao, sp.data_atualizacao,
   case when sp.codigo = 0 then 'Em andamento'
        when sp.codigo = 1 then 'Cancelado'
        when sp.codigo = 2 then 'Realizado'
        when sp.codigo = 3 then 'NF emitida'
        when sp.codigo = 4 then 'Separando'
        when sp.codigo = 5 then 'Em transporte'
        when sp.codigo = 6 then 'Entregue'
        else '<desconhecido>'
   end as status
from pedido as p inner join status_pedido as sp on sp.pedido_id = p.pedido_id;

-- recuperando a última atualização do status de um pedido
select p.pedido_id, p.descricao, max(sp.data_atualizacao) as atualizacao,
   case when sp.codigo = 0 then 'Em andamento'
        when sp.codigo = 1 then 'Cancelado'
        when sp.codigo = 2 then 'Realizado'
        when sp.codigo = 3 then 'NF emitida'
        when sp.codigo = 4 then 'Separando'
        when sp.codigo = 5 then 'Em transporte'
        when sp.codigo = 6 then 'Entregue'
        else '<desconhecido>'
   end as status
from pedido as p inner join status_pedido as sp on sp.pedido_id = p.pedido_id
where p.pedido_id = 1;

-- recuperando o histórico de status de um pedido
select p.pedido_id as pedido, p.descricao, sp.data_atualizacao as atualizacao,
   case when sp.codigo = 0 then 'Em andamento'
        when sp.codigo = 1 then 'Cancelado'
        when sp.codigo = 2 then 'Realizado'
        when sp.codigo = 3 then 'NF emitida'
        when sp.codigo = 4 then 'Separando'
        when sp.codigo = 5 then 'Em transporte'
        when sp.codigo = 6 then 'Entregue'
        else '<desconhecido>'
   end as status
from pedido as p inner join status_pedido as sp on sp.pedido_id = p.pedido_id
where p.pedido_id = 2;