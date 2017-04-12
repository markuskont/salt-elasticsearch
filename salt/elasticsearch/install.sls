{%- set vars = pillar['elasticsearch']['config'] -%}

{% if vars.path.data is iterable and vars.path.data is not string %}
  {% set datadirs = vars.path.data %}
{% else %}
  {% set datadirs = vars['path']['data'].split(',') %}
{% endif %}

elasticsearch:
  pkg.latest:
    - require:
      - pkgrepo: elasticsearch-repo
  service.running:
    - enable: True
    - require:
      {% for dir in datadirs %}
      - file: {{ dir }}
      {% endfor %}
      - pkg: elasticsearch
    - watch:
      - file: /etc/elasticsearch/jvm.options
      - file: /etc/elasticsearch/elasticsearch.yml

{% if datadirs is iterable %}
  {% for dir in datadirs %}
elastic.datadir.create.{{ dir }}:
  file.directory:
    - name: {{ dir }}
    - user: elasticsearch
    - group: elasticsearch
    - mode: 750
    - makedirs: True
    - require:
      - pkg: elasticsearch
  {% endfor %}
{% else %}
Fail - datadir definition must be array or comma separated string of elements
  test.fail_without_changes
{% endif %}
