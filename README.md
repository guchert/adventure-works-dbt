# Adventure Works: data warehouse de vendas com dbt

Projeto da certificação em Analytics Engineer da Indicium. Transforma os dados brutos do sistema transacional da Adventure Works em um data warehouse dimensional no Databricks, consumido por um painel de vendas no Power BI.

## Arquitetura

| Camada | Onde fica | O que contém |
| --- | --- | --- |
| Dados brutos | `fea_academy.adventure_works` | Tabelas do sistema de origem, carregadas sem transformação |
| Staging | `adventure_works_dw.staging` | Limpeza, tipos e nomes padronizados, uma view por tabela de origem |
| Intermediate | `adventure_works_dw.intermediate` | Joins e regras de negócio |
| Marts | `adventure_works_dw.marts` | Dimensões e fato do esquema estrela |

## Como executar

```
dbt deps
dbt build
```

## Autor

Leonardo Guchert Miranda