with
    enderecos as (
        select *
        from {{ ref('stg_erp__enderecos') }}
    )

    , estados as (
        select *
        from {{ ref('stg_erp__estados') }}
    )

    , paises as (
        select *
        from {{ ref('stg_erp__paises') }}
    )

    , localizacoes as (
        select
            enderecos.pk_endereco as pk_localizacao
            , enderecos.cidade
            , estados.sigla_estado
            , estados.nome_estado as estado
            , paises.pk_pais as codigo_pais
            , paises.nome_pais as pais
        from enderecos
        left join estados on enderecos.fk_estado = estados.pk_estado
        left join paises on estados.fk_pais = paises.pk_pais
    )

select *
from localizacoes