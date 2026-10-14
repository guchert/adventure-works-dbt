with
    fonte as (
        select *
        from {{ source('erp', 'person_person') }}
    )

    , renomeado as (
        select
            cast(businessentityid as int) as pk_pessoa
            , persontype as tipo_pessoa
            , trim(firstname) as primeiro_nome
            , trim(lastname) as ultimo_nome
            -- concat_ws ignora os vazios, então quem não tem nome do meio fica sem espaço duplo.
            , concat_ws(' ', trim(firstname), trim(middlename), trim(lastname)) as nome_completo
        from fonte
    )

select *
from renomeado