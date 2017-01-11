DEVEL:
  'roles:elasticsearch':
    - match: grain
    - elasticsearch
  'G@roles:elasticsearch and G@roles:proxy':
    - match: compound
    - kibana
  'G@roles:elasticsearch and G@roles:ingest and G@oscodename:trusty':
    - match: compound
    - rsyslog
    - kafka
    - elasticsearch.template
