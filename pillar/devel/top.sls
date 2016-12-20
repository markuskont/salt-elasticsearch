base:
  '^es-(?:master|proxy|data|gw)-\d+\S*$':
    - match: pcre
    - elastic
    - saltmine
devel:
  '^es-(?:master|proxy|data|gw)-\d+\S*$':
    - match: pcre
    - elastic
    - saltmine
