#/etc/default/elasticsearch:
#  file.managed:
#    - mode: 644
#    - source: salt://elasticsearch/etc/default/elasticsearch.jinja
#    - template: jinja

#/etc/elasticsearch/jvm.options:
#  file.managed:
#    - mode: 644
#    - source: salt://TODO
