with 
    fonte_contas as (
        select *
        from {{ source('erp', 'contas') }}
    )

    , renomeado as (
        select
            cast(num_conta as int) as pk_conta
            , cast(cod_cliente as int) as fk_cliente
            , cast(cod_agencia as int) as fk_agencia
            , cast(cod_colaborador as int) as fk_colaborador
            , tipo_conta
            , cast(data_abertura as date) as data_abertura_conta
            , cast(saldo_total as decimal(18,2)) as saldo_total_conta
            , cast(saldo_disponivel as decimal(18,2)) as saldo_disponivel_conta
            , cast(data_ultimo_lancamento as date) as data_ultimo_lancamento_conta
        from fonte_contas
    )
select *
from renomeado