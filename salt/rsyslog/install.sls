{% set vars = pillar['rsyslog-gateway'] %}
rsyslog:
  pkgrepo.managed:
    - humanname: Rsyslog Adiscon repository
    - ppa: adiscon/v8-stable
  pkg.latest:
    - pkgs:
      - rsyslog
      - rsyslog-mmjsonparse
      - rsyslog-elasticsearch
      - rsyslog-kafka
      - rsyslog-mmnormalize
    - refresh: True
  service.running:
    - name: rsyslog
    - enable: True
    - watch:
      - file: /etc/rsyslog.d/05-udp-server.conf
      - file: /etc/rsyslog.d/14-kafka.conf
      - file: {{vars['ruledir']}}/apache.rb
      #- file: /etc/rsyslog.d/15-elastic.conf
