## Modelagem de um banco de dados para controle de Ordens de Serviço em uma oficina mecânica

### Especificidades da Ordem de Serviço

O requisitos relacionados À OS são:

* Número -> representado pelo ID da OS na entidade;
* Data da emissão -> também consta na entidade Ordem de Serviço;
* Valor -> este atributu deverá ser calculado dinamicamente pelo software que consumirá os dados;
* Status -> também pode ser inferido pelos dados constantes tanto na entidade Ordem de Serviço, quanto nas entidades relacionadas relacionadas a ela (itens peças e itens serviços). Por exemplo:
  * Caso não existam serviços ou peças cadastrados nos itens da OS, esta apresentará o Status de NÃO INICIADA e, caso contrário, INICIADA ou EM ANDAMENTO;
  * Caso a data prevista seja menor que a data "atual" do sistema, implica que a OS está ATRASADA;
  * Caso o atribubo data_conclusão estaja preenchido, implica dizer que a OS fora CONCLUÍDA.