with
    fonte as (
        select *
        from {{ source('erp', 'production_productcategory') }}
    )

    , renomeado as (
        select
            cast(productcategoryid as int) as pk_categoria
            , trim(name) as nome_categoria
        from fonte
    )

select *
from renomeado