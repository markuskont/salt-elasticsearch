base:
  '*':
    - elasticsearch
  '^es-proxy-\d+\S*$':
    - match: pcre
    - kibana
