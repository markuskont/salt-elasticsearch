{%- set vars = pillar['elasticsearch'] -%}

{{vars['path.data']}}:
  file.directory:
    - user: elasticsearch
    - group: elasticsearch
    - mode: 750
    - makedirs: True
