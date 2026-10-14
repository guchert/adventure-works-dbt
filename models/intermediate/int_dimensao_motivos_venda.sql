with
    motivos as (
        select
            pk_motivo_venda
            , nome_motivo
            , tipo_motivo
        from {{ ref('stg_erp__motivos_venda') }}
    )

    -- Linha para os pedidos sem motivo de venda registrado.
    , sem_motivo as (
        select
            -1 as pk_motivo_venda
            , 'Sem motivo informado' as nome_motivo
            , 'Sem motivo informado' as tipo_motivo
    )

select * from motivos
union all
select * from sem_motivo