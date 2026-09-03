{% macro payment_status_count(status) %}

    count_if(status = '{{ status }}')

{% endmacro %}
