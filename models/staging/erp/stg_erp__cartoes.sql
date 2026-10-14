with
    fonte as (
        select *
        from {{ source('erp', 'sales_creditcard') }}
    )

    -- O número do cartão não é trazido: é um dado sensível e nenhuma análise usa.
    , renomeado as (
        select
            cast(creditcardid as int) as pk_cartao
            , trim(cardtype) as tipo_cartao
        from fonte
    )

select *
from renomeado