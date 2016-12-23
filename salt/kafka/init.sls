{% if pillar['kafka']['manage'] == true %}
include:
  - java
  - kafka.install
  - kafka.config
{% endif %}
