with
    contas as (
        select *
        from {{ ref('stg_erp__contas') }}
    )

    , selecionar_colunas as (
        select
            pk_conta
            , fk_cliente
            , fk_agencia
            , fk_colaborador
            , saldo_total_conta as saldo_total
            , saldo_disponivel_conta as saldo_disponivel
            , data_ultimo_lancamento_conta
        from contas
    )

select *
from selecionar_colunas