include:
  - elastic-cluster.elasticsearch.repo
  - elastic-cluster.kibana.install
  - elastic-cluster.kibana.config
  {% if pillar.kibana["manage.tls"] == true %}
  - elastic-cluster.kibana.tls
  {% endif %}
