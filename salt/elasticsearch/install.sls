elasticsearch:
  pkg.installed:
    - require:
      - pkgrepo: elasticsearch-repo
  service.running:
    - name: elasticsearch
    - enable: True
    - watch:
#      - file: /etc/elasticsearch/elasticsearch.yml
      - file: /etc/default/elasticsearch
