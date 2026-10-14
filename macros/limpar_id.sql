{#
    Converte para inteiro uma coluna de identificador que chegou como decimal.
    Na ingestão, o pandas transformou em decimal as colunas de chave que têm
    valores vazios. Esta macro trata o NaN como vazio e devolve um inteiro.
#}
{% macro limpar_id(coluna) -%}
    cast(case when isnan({{ coluna }}) then null else {{ coluna }} end as int)
{%- endmacro %}