with
    -- Gera um dia por linha, de 01/01/2011 a 31/12/2014, cobrindo todo o período dos pedidos.
    calendario as (
        {{
            dbt_utils.date_spine(
                datepart = "day",
                start_date = "cast('2011-01-01' as date)",
                end_date = "cast('2015-01-01' as date)"
            )
        }}
    )

    , datas as (
        select
            cast(date_day as date) as pk_data
            , day(date_day) as dia
            , month(date_day) as mes
            , case month(date_day)
                when 1 then 'Janeiro'
                when 2 then 'Fevereiro'
                when 3 then 'Março'
                when 4 then 'Abril'
                when 5 then 'Maio'
                when 6 then 'Junho'
                when 7 then 'Julho'
                when 8 then 'Agosto'
                when 9 then 'Setembro'
                when 10 then 'Outubro'
                when 11 then 'Novembro'
                when 12 then 'Dezembro'
            end as nome_mes
            , quarter(date_day) as trimestre
            , year(date_day) as ano
            , date_format(date_day, 'yyyy-MM') as ano_mes
            , dayofweek(date_day) as dia_semana
            , case dayofweek(date_day)
                when 1 then 'Domingo'
                when 2 then 'Segunda-feira'
                when 3 then 'Terça-feira'
                when 4 then 'Quarta-feira'
                when 5 then 'Quinta-feira'
                when 6 then 'Sexta-feira'
                when 7 then 'Sábado'
            end as nome_dia_semana
        from calendario
    )

select *
from datas