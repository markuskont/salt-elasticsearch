DEVEL:
  'roles:elasticsearch':
    - match: grain
    - elasticsearch
  '^es-proxy-\d+\S*$':
    - match: pcre
    - kibana
  'E@^es-gw-\d+\S*$ and G@oscodename:trusty':
    - match: compound
    - rsyslog
    - elasticsearch.template
