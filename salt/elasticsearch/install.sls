{%- set vars = pillar['elasticsearch'] -%}
elasticsearch:
  pkg.installed:
    - require:
      - pkgrepo: elasticsearch-repo
  file.directory:
    - name: {{vars['path.data']}}
    - user: elasticsearch
    - group: elasticsearch
    - mode: 750
    - makedirs: True
    - require:
      - pkg: elasticsearch
  service.running:
    - enable: True
    - reload: True
    - require:
      - file: {{vars['path.data']}}
      - pkg: elasticsearch
    - watch:
      - file: /etc/elasticsearch/jvm.options
      - file: /etc/elasticsearch/elasticsearch.yml
