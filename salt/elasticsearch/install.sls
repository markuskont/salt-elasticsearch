{%- set vars = pillar['elasticsearch']['config'] -%}
elasticsearch:
  pkg.installed:
    - require:
      - pkgrepo: elasticsearch-repo
  service.running:
    - enable: True
    - require:
      {% for dir in vars.path.data %}
      - file: {{ dir }}
      {% endfor %}
      - pkg: elasticsearch
    - watch:
      - file: /etc/elasticsearch/jvm.options
      - file: /etc/elasticsearch/elasticsearch.yml

{% for dir in vars.path.data %}
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
