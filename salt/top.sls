DEVEL:
  'es-*':
    - elasticsearch
  '^es-proxy-\d+\S*$':
    - match: pcre
    - kibana
