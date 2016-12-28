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
    - require:
      - pkg: rsyslog

/etc/rsyslog.d/50-default.conf:
  file.absent
