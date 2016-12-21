/etc/rsyslog.d/05-udp-server.conf:
  file.managed:
    - mode: 644
    - source: salt://rsyslog/etc/rsyslog.d/00-udp-server.conf
    - template: jinja

/etc/rsyslog.d/15-elastic.conf:
  file.managed:
    - mode: 644
    - source: salt://rsyslog/etc/rsyslog.d/15-elastic.conf
    - template: jinja

/etc/rsyslog.d/50-default.conf:
  file.absent
