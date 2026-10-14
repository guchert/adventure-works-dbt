with
    cartoes as (
        select
            pk_cartao
            , tipo_cartao
        from {{ ref('stg_erp__cartoes') }}
    )

    -- Linha para os pedidos pagos sem cartão. A chave -1 é a convenção
    -- para "não informado": a fato aponta para ela quando o cartão está vazio.
    , sem_cartao as (
        select
            -1 as pk_cartao
            , 'Sem cartão' as tipo_cartao
    )

select * from cartoes
union all
select * from sem_cartao