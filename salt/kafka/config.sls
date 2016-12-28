{% set vars = pillar['kafka'] %}
{{vars['confdir']}}:
  file.directory:
    - mode: 755

{{vars['confdir']}}/config.properties:
  file.managed:
    - mode: 644
    - template: jinja
    - source: salt://kafka/etc/kafka/server.properties
    - require:
      - {{vars['logdir']}}
      - {{vars['confdir']}}
