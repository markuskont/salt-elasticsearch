/etc/kafka:
  file.directory:
    - mode: 755

/etc/kafka/config.properties:
  file.managed:
    - mode: 644
    - template: jinja
    - source: salt://kafka/etc/kafka/server.properties
    - require:
      - /var/log/kafka
      - /etc/kafka
