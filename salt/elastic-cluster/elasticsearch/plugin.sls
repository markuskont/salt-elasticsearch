{% if 'plugins' in pillar.elasticsearch %}

{% for pkg in pillar.elasticsearch.plugins %}

{{ pkg }}:
  cmd.run:
    - name: /usr/share/elasticsearch/bin/elasticsearch-plugin install {{ pkg }}
    - unless: /usr/share/elasticsearch/bin/elasticsearch-plugin list | grep {{ pkg }}
    - require:
      - pkg: elasticsearch
    - listen_in:
      - service: elasticsearch

{% endfor %}

{% endif %}
