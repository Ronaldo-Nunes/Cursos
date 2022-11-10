## Projeto conceitual de banco de dados para E-Commerce

O presente projeto tem por objetivo mapear as entidades inerentes a uma empresa de E-Commmerce, no entanto, em um escopo restrito à venda de produtos. Portanto, não foram considerados os prováveis inúmeros outros cenários presentes em um empreendimento dessa categoria.

1. Quanto à entrega, optou-se por incluir a data de entrega e o código de rastreio na entidade pedido. 
2. O Software deverá, provavelmente, consumir uma API da transportadora informando a localização do pacote a partir do código de rastreio.
3. Caso não haja código cadstrado, é possível perceber que o pedido ainda encontra-se em separação.
4. Quando a data de entrega é informada, significa que o pedido foi entregue.

Ainda sim, optou-se por criar uma entidade que guarda a atualização das etapas do pedido a fim de prover um melhor acompanahmento do pedido.