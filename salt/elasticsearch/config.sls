/etc/elasticsearch/jvm.options:
  file.managed:
    - mode: 644
    - source: salt://elasticsearch/etc/elasticsearch/jvm.options
    - template: jinja
    
/etc/elasticsearch/elasticsearch.yml:
  file.managed:
    - mode: 644
    - source: salt://elasticsearch/etc/elasticsearch/elasticsearch.yml
    - template: jinja
