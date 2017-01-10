{%- set vars = pillar['elasticsearch']['config'] -%}
{% set glob = grains['fqdn'] %}

{% for type in ['master', 'data', 'ingest'] %}
  {% if type in grains['roles'] %}
    {% do vars['node'].update({type:true}) %}
  {% endif %}
{% endfor %}

{% if 'proxy' in grains['roles'] %}
  {% do vars['http'].update({
    'enabled':true,
    'host':'0.0.0.0'
  }) %}
{% endif %}

{% if 'ingest' in grains['roles'] %}
  {% do vars['http'].update({
    'enabled':true
  }) %}
{% endif %}

{% do vars['network'].update({
  'host':salt['mine.get'](glob, 'es_cluster_ip_addr', expr_form='glob')[glob][0]
}) %}

/etc/elasticsearch/jvm.options:
  file.managed:
    - mode: 644
    - source: salt://elasticsearch/etc/elasticsearch/jvm.options
    - template: jinja

/etc/elasticsearch/elasticsearch.yml:
  file.serialize:
    - mode: 644
    - dataset: {{vars}}
    - formatter: yaml
