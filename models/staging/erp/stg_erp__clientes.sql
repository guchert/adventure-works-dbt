with
    fonte as (
        select *
        from {{ source('erp', 'sales_customer') }}
    )

    , renomeado as (
        select
            cast(customerid as int) as pk_cliente
            , {{ limpar_id('personid') }} as fk_pessoa
            , {{ limpar_id('storeid') }} as fk_loja
            , cast(territoryid as int) as fk_territorio
        from fonte
    )

select *
from renomeado