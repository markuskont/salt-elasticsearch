base:
  'es-*':
    - elasticsearch
  '^es-proxy-\d+\S*$':
    - match: pcre
    - kibana
devel:
  'es-*':
    - elasticsearch
  '^es-proxy-\d+\S*$':
    - match: pcre
    - kibana
