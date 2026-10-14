with
    fct_vendas as (
        select
            pk_item_pedido
            , numero_pedido
            , fk_produto
            , fk_cliente
            , fk_cartao
            , fk_localizacao
            , fk_data
            , status_pedido
            , quantidade_comprada
            , preco_unitario
            , percentual_desconto
            , valor_bruto
            , valor_desconto
            , valor_liquido
        from {{ ref('int_fato_vendas') }}
    )

select *
from fct_vendas