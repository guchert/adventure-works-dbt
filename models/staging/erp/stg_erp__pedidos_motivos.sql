with
    fonte as (
        select *
        from {{ source('erp', 'sales_salesorderheadersalesreason') }}
    )

    , renomeado as (
        select
            cast(salesorderid as int) as fk_pedido
            , cast(salesreasonid as int) as fk_motivo_venda
        from fonte
    )

select *
from renomeado