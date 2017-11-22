{%- set vars = pillar.kibana -%}
elastic-cluster.kibana:
  pkg.latest:
    - name: kibana
    - require:
      - pkgrepo: elastic-cluster.elasticsearch-repo
  service.running:
    - name: kibana
    - enable: True
    - watch:
      - file: /etc/kibana/kibana.yml
      {% if vars["manage.tls"] == true %}
      - file: {{vars['ssl.key']}}
      - file: {{vars['ssl.cert']}}
      {% endif %}
    - require:
      - pkg: elastic-cluster.kibana
      {% if vars["manage.tls"] == true %}
      - file: {{vars['ssl.key']}}
      - file: {{vars['ssl.cert']}}
      {% endif %}
