with
    ponte_pedidos_motivos as (
        select
            pk_pedido_motivo
            , numero_pedido
            , fk_motivo_venda
        from {{ ref('int_ponte_pedidos_motivos') }}
    )

select *
from ponte_pedidos_motivos