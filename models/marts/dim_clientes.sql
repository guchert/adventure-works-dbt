with
    dim_clientes as (
        select
            pk_cliente
            , nome_cliente
            , tipo_cliente
            , nome_loja
        from {{ ref('int_dimensao_clientes') }}
    )

select *
from dim_clientes