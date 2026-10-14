with
    dim_datas as (
        select
            pk_data
            , dia
            , mes
            , nome_mes
            , trimestre
            , ano
            , ano_mes
            , dia_semana
            , nome_dia_semana
        from {{ ref('int_dimensao_datas') }}
    )

select *
from dim_datas