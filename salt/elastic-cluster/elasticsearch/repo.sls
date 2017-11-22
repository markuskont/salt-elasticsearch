elastic-cluster.apt-transport-https:
  pkg.latest:
    - name: apt-transport-https

elastic-cluster.elasticsearch-repo:
  pkgrepo.managed:
    - humanname: Elasticsearch repository
    - name: deb https://artifacts.elastic.co/packages/5.x/apt stable main
    - key_url: https://artifacts.elastic.co/GPG-KEY-elasticsearch
    - file: /etc/apt/sources.list.d/elasticsearch.list
    - clean_file: True
