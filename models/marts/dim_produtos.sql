with
    dim_produtos as (
        select
            pk_produto
            , nome_produto
            , numero_produto
            , subcategoria
            , categoria
            , cor
            , custo_padrao
            , preco_lista
        from {{ ref('int_dimensao_produtos') }}
    )

select *
from dim_produtos