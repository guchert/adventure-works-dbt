with
    fonte as (
        select *
        from {{ source('erp', 'sales_store') }}
    )

    , renomeado as (
        select
            cast(businessentityid as int) as pk_loja
            , trim(name) as nome_loja
            , cast(salespersonid as int) as fk_vendedor
        from fonte
    )

select *
from renomeado