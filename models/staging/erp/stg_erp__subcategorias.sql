with
    fonte as (
        select *
        from {{ source('erp', 'production_productsubcategory') }}
    )

    , renomeado as (
        select
            cast(productsubcategoryid as int) as pk_subcategoria
            , cast(productcategoryid as int) as fk_categoria
            , trim(name) as nome_subcategoria
        from fonte
    )

select *
from renomeado