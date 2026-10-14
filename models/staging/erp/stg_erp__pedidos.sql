with
    fonte as (
        select *
        from {{ source('erp', 'sales_salesorderheader') }}
    )

    , renomeado as (
        select
            cast(salesorderid as int) as pk_pedido
            , cast(customerid as int) as fk_cliente
            , {{ limpar_id('salespersonid') }} as fk_vendedor
            , {{ limpar_id('creditcardid') }} as fk_cartao
            , cast(billtoaddressid as int) as fk_endereco_cobranca
            , cast(shiptoaddressid as int) as fk_endereco_entrega
            , cast(territoryid as int) as fk_territorio
            , cast(orderdate as date) as data_pedido
            , cast(duedate as date) as data_vencimento
            , cast(shipdate as date) as data_envio
            , cast(status as int) as codigo_status
            , case cast(status as int)
                when 1 then 'Em processamento'
                when 2 then 'Aprovado'
                when 3 then 'Em espera'
                when 4 then 'Rejeitado'
                when 5 then 'Enviado'
                when 6 then 'Cancelado'
            end as status_pedido
            , onlineorderflag as is_pedido_online
            , cast(subtotal as decimal(19, 4)) as valor_subtotal
            , cast(taxamt as decimal(19, 4)) as valor_imposto
            , cast(freight as decimal(19, 4)) as valor_frete
            , cast(totaldue as decimal(19, 4)) as valor_total
        from fonte
    )

select *
from renomeado