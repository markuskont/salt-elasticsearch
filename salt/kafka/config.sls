/etc/kafka:
  file.directory:
    - user: kafka
    - group: kafka
    - mode: 755

/etc/kafka/config.properties:
  file.managed:
    - user: kafka
    - group: kafka
    - mode: 755
    - source: salt://kafka/etc/kafka/server.properties
    - require:
      - /var/log/kafka
      - /etc/kafka
