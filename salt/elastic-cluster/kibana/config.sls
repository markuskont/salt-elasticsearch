/etc/kibana/kibana.yml:
  file.managed:
    - mode: 644
    - source: salt://elastic-cluster/kibana/etc/kibana/kibana.yml
    - template: jinja
