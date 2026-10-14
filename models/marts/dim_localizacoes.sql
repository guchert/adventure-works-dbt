with
    dim_localizacoes as (
        select
            pk_localizacao
            , cidade
            , sigla_estado
            , estado
            , codigo_pais
            , pais
        from {{ ref('int_dimensao_localizacoes') }}
    )

select *
from dim_localizacoes