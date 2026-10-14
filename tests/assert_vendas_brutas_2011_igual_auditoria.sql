/*
    Teste de dados pedido pelo CEO, Carlos Silveira.

    As vendas brutas de 2011 no data warehouse precisam bater com o valor
    levantado pela auditoria da contabilidade: US$ 12.646.112,16.

    Vendas brutas = soma de preço unitário x quantidade, sem descontos.

    Um teste singular do dbt passa quando a consulta não devolve nenhuma linha.
    Esta consulta só devolve uma linha se o valor calculado for diferente do auditado.
*/

with
    vendas_2011 as (
        select round(sum(valor_bruto), 2) as vendas_brutas
        from {{ ref('fct_vendas') }}
        where year(fk_data) = 2011
    )

select vendas_brutas
from vendas_2011
where vendas_brutas <> 12646112.16