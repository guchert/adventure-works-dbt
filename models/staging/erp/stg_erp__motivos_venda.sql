with
    fonte as (
        select *
        from {{ source('erp', 'sales_salesreason') }}
    )

    , renomeado as (
        select
            cast(salesreasonid as int) as pk_motivo_venda
            , trim(name) as nome_motivo
            , trim(reasontype) as tipo_motivo
        from fonte
    )

select *
from renomeado