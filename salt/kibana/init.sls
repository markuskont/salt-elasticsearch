{%- set vars = pillar['kibana'] -%}
include:
  - elasticsearch.repo
  - kibana.install
  - kibana.config
  {% if vars['manage.tls'] == true %}
  - kibana.tls
  {% endif %}
