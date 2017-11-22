{% set vars = pillar['rsyslog-gateway'] %}
/etc/rsyslog.d/05-udp-server.conf:
  file.managed:
    - mode: 644
    - source: salt://rsyslog/etc/rsyslog.d/05-udp-server.conf
    - template: jinja
    - require:
      - pkg: rsyslog

#/etc/rsyslog.d/15-elastic.conf:
#  file.managed:
#    - mode: 644
#    - source: salt://rsyslog/etc/rsyslog.d/15-elastic.conf
#    - template: jinja
#    - require:
#      - pkg: rsyslog

/etc/rsyslog.d/14-kafka.conf:
  file.managed:
    - mode: 644
    - source: salt://rsyslog/etc/rsyslog.d/14-kafka.conf
    - template: jinja
    - defaults:
      apacherules: {{vars['ruledir']}}/apache.rb
      kafkahost: 'localhost'
      kafkaport: 9092
    - require:
      - pkg: rsyslog
      - {{vars['ruledir']}}/apache.rb

/etc/rsyslog.d/50-default.conf:
  file.absent
