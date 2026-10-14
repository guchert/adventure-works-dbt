with
    pedidos as (
        select pk_pedido
        from {{ ref('stg_erp__pedidos') }}
    )

    , pedidos_motivos as (
        select
            fk_pedido
            , fk_motivo_venda
        from {{ ref('stg_erp__pedidos_motivos') }}
    )

    -- Parte de todos os pedidos, para que os pedidos sem motivo também tenham uma linha.
    -- Eles apontam para o motivo -1, "Sem motivo informado".
    , ponte as (
        select
            pedidos.pk_pedido as numero_pedido
            , coalesce(pedidos_motivos.fk_motivo_venda, -1) as fk_motivo_venda
        from pedidos
        left join pedidos_motivos on pedidos.pk_pedido = pedidos_motivos.fk_pedido
    )

select
    {{ dbt_utils.generate_surrogate_key(['numero_pedido', 'fk_motivo_venda']) }} as pk_pedido_motivo
    , numero_pedido
    , fk_motivo_venda
from ponte