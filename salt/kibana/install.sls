{%- set vars = pillar['kibana'] -%}
kibana:
  pkg.installed:
    - require:
      - pkgrepo: elasticsearch-repo
  service.running:
    - enable: True
    - watch:
      - file: /etc/kibana/kibana.yml
      - file: {{vars['ssl.key']}}
      - file: {{vars['ssl.cert']}}
    - require:
      - {{vars['ssl.key']}}
      - {{vars['ssl.cert']}}
