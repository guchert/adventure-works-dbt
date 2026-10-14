# Adventure Works: data warehouse de vendas com dbt

Projeto da certificação em Analytics Engineer da Indicium. Transforma os dados brutos do sistema transacional (ERP) da Adventure Works em um data warehouse dimensional no Databricks, consumido por um painel de vendas no Power BI.

## Arquitetura

| Camada | Onde fica | O que contém |
| --- | --- | --- |
| Dados brutos | `fea_academy.adventure_works` | 68 tabelas do ERP, carregadas sem transformação. O modelo usa 14 delas. |
| Staging | `adventure_works_dw.staging` | 14 views: uma por tabela de origem, com tipos, nomes e vazios padronizados. |
| Intermediate | `adventure_works_dw.intermediate` | 8 views com os joins e as regras de negócio de cada dimensão e da fato. |
| Marts | `adventure_works_dw.marts` | 8 tabelas do esquema estrela, lidas pelo Power BI. |

## Modelo dimensional

Esquema estrela com grão no item do pedido.

| Tabela | Uma linha por | Conteúdo |
| --- | --- | --- |
| `fct_vendas` | Item de pedido | Chaves das dimensões, status, quantidade, preço, desconto, valor bruto, valor do desconto e valor líquido |
| `dim_produtos` | Produto | Nome, subcategoria e categoria |
| `dim_clientes` | Cliente | Nome, tipo de cliente e loja |
| `dim_cartoes` | Cartão | Tipo de cartão, mais a linha "Sem cartão" |
| `dim_localizacoes` | Endereço | Cidade, estado e país (endereço de entrega) |
| `dim_datas` | Dia | Dia, mês, trimestre e ano, de 2011 a 2014 |
| `dim_motivos_venda` | Motivo de venda | Nome e tipo do motivo, mais a linha "Sem motivo informado" |
| `ponte_pedidos_motivos` | Par de pedido e motivo | Liga a fato aos motivos sem duplicar valores |

Um pedido pode ter até três motivos de venda. Para que o valor de um pedido não seja contado mais de uma vez, os motivos se ligam à fato por uma tabela ponte, e não diretamente.

## Métricas

| Métrica | Cálculo |
| --- | --- |
| Número de pedidos | Contagem distinta de `numero_pedido` |
| Quantidade comprada | Soma de `quantidade_comprada` |
| Valor total negociado | Soma de `valor_bruto` (preço unitário x quantidade) |
| Valor negociado líquido | Soma de `valor_liquido` (valor bruto x (1 - desconto)) |
| Ticket médio | Valor líquido / número de pedidos |

## Qualidade dos dados

- **Testes de source:** chaves únicas e sem vazio, campos obrigatórios, relacionamentos entre tabelas e valores aceitos nas 14 tabelas de origem.
- **Testes de chave primária:** `unique` e `not_null` em todas as dimensões, na ponte e na fato.
- **Testes de relacionamento:** toda chave estrangeira da fato aponta para uma linha existente na dimensão.
- **Teste de dados da auditoria:** `tests/assert_vendas_brutas_2011_igual_auditoria.sql` confere que as vendas brutas de 2011 somam US$ 12.646.112,16, o valor levantado pela contabilidade.
- **Defeito conhecido da ingestão:** o código de país "NA" (Namíbia) foi lido como valor ausente. O teste de source registra o defeito como aviso, e o modelo `stg_erp__paises` restaura o código.

## Como executar

```
dbt deps
dbt build
```

Para executar só os testes de source:

```
dbt test --select "source:*"
```

## Autor

Leonardo Guchert Miranda