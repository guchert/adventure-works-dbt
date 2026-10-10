{#
    Define o nome do schema onde cada modelo é gravado.
    Por padrão, o dbt junta o schema do usuário com o schema da camada
    (por exemplo, dbt_lmiranda_staging). Esta macro usa apenas o nome da
    camada, para que o data warehouse tenha schemas limpos:
    staging, intermediate e marts.
#}
{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- if custom_schema_name is none -%}

        {{ target.schema }}

    {%- else -%}

        {{ custom_schema_name | trim }}

    {%- endif -%}

{%- endmacro %}