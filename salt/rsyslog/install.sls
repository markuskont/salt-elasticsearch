{% if grains['oscodename'] == 'trusty' %}
rsyslog:
  pkgrepo.managed:
    - humanname: Rsyslog Adiscon repository
    - ppa: adiscon/v8-stable
  pkg.latest:
    - pkgs:
      - rsyslog
      - rsyslog-mmjsonparse
      - rsyslog-elasticsearch
    - refresh: True
  service.running:
    - name: rsyslog
    - enable: True
    - reload: True
    - watch:
      - file: /etc/rsyslog.d/00-udp-server.conf
      - file: /etc/rsyslog.d/15-elastic.conf
{% endif %}
