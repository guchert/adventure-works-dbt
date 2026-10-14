with
    fonte as (
        select *
        from {{ source('erp', 'person_countryregion') }}
    )

    , renomeado as (
        select
            -- Na ingestão, o pandas leu o código "NA" da Namíbia como valor ausente.
            -- Aqui o código original é restaurado. O teste de source registra o defeito.
            case
                when countryregioncode is null and name = 'Namibia' then 'NA'
                else trim(countryregioncode)
            end as pk_pais
            , trim(name) as nome_pais
        from fonte
    )

select *
from renomeado