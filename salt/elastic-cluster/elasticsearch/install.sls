{%- set vars = pillar.elasticsearch.config -%}

{% if vars.path.data is iterable and vars.path.data is not string %}
  {% set datadirs = vars.path.data %}
{% else %}
  {% set datadirs = vars['path']['data'].split(',') %}
{% endif %}

elastic-cluster.elasticsearch:
  pkg.latest:
    - name: elasticsearch
    - require:
      - pkgrepo: elastic-cluster.elasticsearch-repo
      - pkg: elastic-cluster.oracle-java8-installer
  service.running:
    - name: elasticsearch
    - enable: True
    - require:
      {% for dir in datadirs %}
      - file: {{ dir }}
      {% endfor %}
      - pkg: elastic-cluster.elasticsearch
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
      - pkg: elastic-cluster.elasticsearch
  {% endfor %}
{% else %}
Fail - datadir definition must be array or comma separated string of elements
  test.fail_without_changes
{% endif %}
