base:
  '^es-(?:master|proxy|data|gw)-\d+\S*$':
    - match: pcre
    - elasticsearch
    - saltmine
#  '*':
#    - elasticsearch
