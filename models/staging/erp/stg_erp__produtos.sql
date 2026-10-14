with
    fonte as (
        select *
        from {{ source('erp', 'production_product') }}
    )

    , renomeado as (
        select
            cast(productid as int) as pk_produto
            , {{ limpar_id('productsubcategoryid') }} as fk_subcategoria
            , trim(name) as nome_produto
            , trim(productnumber) as numero_produto
            , color as cor
            , cast(standardcost as decimal(19, 4)) as custo_padrao
            , cast(listprice as decimal(19, 4)) as preco_lista
            , makeflag as is_fabricado
            , finishedgoodsflag as is_produto_acabado
            , cast(sellstartdate as date) as data_inicio_venda
            , cast(sellenddate as date) as data_fim_venda
        from fonte
    )

select *
from renomeado