with
    dim_cartoes as (
        select
            pk_cartao
            , tipo_cartao
        from {{ ref('int_dimensao_cartoes') }}
    )

select *
from dim_cartoes