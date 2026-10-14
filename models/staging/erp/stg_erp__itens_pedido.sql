with
    fonte as (
        select *
        from {{ source('erp', 'sales_salesorderdetail') }}
    )

    , renomeado as (
        select
            cast(salesorderdetailid as int) as pk_item_pedido
            , cast(salesorderid as int) as fk_pedido
            , cast(productid as int) as fk_produto
            , cast(orderqty as int) as quantidade_comprada
            , cast(unitprice as decimal(19, 4)) as preco_unitario
            , cast(unitpricediscount as decimal(19, 4)) as percentual_desconto
        from fonte
    )

select *
from renomeado