with
    itens as (
        select *
        from {{ ref('stg_erp__itens_pedido') }}
    )

    , pedidos as (
        select *
        from {{ ref('stg_erp__pedidos') }}
    )

    -- O grão da fato é o item do pedido. O cabeçalho entra para trazer
    -- a data, o cliente, o cartão, o endereço de entrega e o status.
    , vendas as (
        select
            itens.pk_item_pedido
            , itens.fk_pedido as numero_pedido
            , itens.fk_produto
            , pedidos.fk_cliente
            , coalesce(pedidos.fk_cartao, -1) as fk_cartao
            , pedidos.fk_endereco_entrega as fk_localizacao
            , pedidos.data_pedido as fk_data
            , pedidos.status_pedido
            , itens.quantidade_comprada
            , itens.preco_unitario
            , itens.percentual_desconto
            , itens.preco_unitario * itens.quantidade_comprada as valor_bruto
            , itens.preco_unitario * itens.quantidade_comprada * itens.percentual_desconto as valor_desconto
            , itens.preco_unitario * itens.quantidade_comprada * (1 - itens.percentual_desconto) as valor_liquido
        from itens
        inner join pedidos on itens.fk_pedido = pedidos.pk_pedido
    )

select *
from vendas