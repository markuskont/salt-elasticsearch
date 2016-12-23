ingest_useragent:
  cmd.run:
    - name: /usr/share/elasticsearch/bin/elasticsearch-plugin install ingest-user-agent
    - unless: /usr/share/elasticsearch/bin/elasticsearch-plugin list | grep ingest-user-agent
    - require:
      - pkg: elasticsearch
    - listen_in:
      - service: elasticsearch

ingest_geoip:
  cmd.run:
    - name: /usr/share/elasticsearch/bin/elasticsearch-plugin install ingest-geoip
    - unless: /usr/share/elasticsearch/bin/elasticsearch-plugin list | grep ingest-geoip
    - require:
      - pkg: elasticsearch
    - listen_in:
      - service: elasticsearch
