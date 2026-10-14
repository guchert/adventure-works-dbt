with
    fonte as (
        select *
        from {{ source('erp', 'person_stateprovince') }}
    )

    , renomeado as (
        select
            cast(stateprovinceid as int) as pk_estado
            , trim(countryregioncode) as fk_pais
            , trim(stateprovincecode) as sigla_estado
            , trim(name) as nome_estado
        from fonte
    )

select *
from renomeado