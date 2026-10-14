with
    clientes as (
        select *
        from {{ ref('stg_erp__clientes') }}
    )

    , pessoas as (
        select *
        from {{ ref('stg_erp__pessoas') }}
    )

    , lojas as (
        select *
        from {{ ref('stg_erp__lojas') }}
    )

    , clientes_enriquecido as (
        select
            clientes.pk_cliente
            -- O dicionário de dados define o cliente pelo nome da pessoa.
            -- Para clientes que são só lojas, o nome da loja é usado no lugar.
            , coalesce(pessoas.nome_completo, lojas.nome_loja) as nome_cliente
            , case
                when clientes.fk_pessoa is not null and clientes.fk_loja is not null then 'Contato de loja'
                when clientes.fk_pessoa is not null then 'Pessoa física'
                else 'Loja'
            end as tipo_cliente
            , lojas.nome_loja
        from clientes
        left join pessoas on clientes.fk_pessoa = pessoas.pk_pessoa
        left join lojas on clientes.fk_loja = lojas.pk_loja
    )

select *
from clientes_enriquecido