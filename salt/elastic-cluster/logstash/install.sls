elastic-cluster.logstash:
  pkg.latest:
    - name: logstash
    - require:
      - pkgrepo: elastic-cluster.elasticsearch-repo
