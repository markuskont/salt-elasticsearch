{%- set ruledir = '/opt/rsyslog' -%}
{% set vars = pillar['rsyslog-gateway'] %}

{{vars['ruledir']}}:
  file.directory:
    - mode: 755

{{vars['ruledir']}}/stdtypes.rb:
  file.managed:
    - source: salt://rsyslog/opt/lognorm/stdtypes.rb
    - mode: 644

{{vars['ruledir']}}/apache.rb:
  file.managed:
    - source: salt://rsyslog/opt/lognorm/apache.rb
    - template: jinja
    - mode: 644
    - defaults:
      ruledir: {{vars['ruledir']}}
    - require:
      - {{vars['ruledir']}}
      - {{vars['ruledir']}}/stdtypes.rb
