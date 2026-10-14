with
    produtos as (
        select *
        from {{ ref('stg_erp__produtos') }}
    )

    , subcategorias as (
        select *
        from {{ ref('stg_erp__subcategorias') }}
    )

    , categorias as (
        select *
        from {{ ref('stg_erp__categorias') }}
    )

    , produtos_enriquecido as (
        select
            produtos.pk_produto
            , produtos.nome_produto
            , produtos.numero_produto
            -- Componentes usados na fabricação não têm subcategoria.
            , coalesce(subcategorias.nome_subcategoria, 'Sem subcategoria') as subcategoria
            , coalesce(categorias.nome_categoria, 'Sem categoria') as categoria
            , produtos.cor
            , produtos.custo_padrao
            , produtos.preco_lista
        from produtos
        left join subcategorias on produtos.fk_subcategoria = subcategorias.pk_subcategoria
        left join categorias on subcategorias.fk_categoria = categorias.pk_categoria
    )

select *
from produtos_enriquecido