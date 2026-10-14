with
    fonte as (
        select *
        from {{ source('erp', 'person_address') }}
    )

    , renomeado as (
        select
            cast(addressid as int) as pk_endereco
            , cast(stateprovinceid as int) as fk_estado
            , trim(city) as cidade
            , trim(postalcode) as codigo_postal
        from fonte
    )

select *
from renomeado