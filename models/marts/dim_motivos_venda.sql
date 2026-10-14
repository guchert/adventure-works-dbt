with
    dim_motivos_venda as (
        select
            pk_motivo_venda
            , nome_motivo
            , tipo_motivo
        from {{ ref('int_dimensao_motivos_venda') }}
    )

select *
from dim_motivos_venda