{%- set vars = pillar['elasticsearch'] -%}
elasticsearch:
  pkg.installed:
    - require:
      - pkgrepo: elasticsearch-repo
  service.running:
    - name: elasticsearch
    - enable: True
    - reload: True
    - require:
      - file: {{vars['path.data']}}
    - watch:
      - file: /etc/elasticsearch/jvm.options
      - file: /etc/elasticsearch/elasticsearch.yml
