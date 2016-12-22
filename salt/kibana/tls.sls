{%- set vars = pillar['kibana'] -%}
{%- set tmpkey = '/etc/ssl/kibana/key.pem' -%}
{%- set tmpcert = '/etc/ssl/kibana/cert.pem' -%}
{{vars['ssl.dir']}}:
  file.directory:
    - mode: 0750
    - user: kibana
    - group: kibana

/etc/ssl/kibana:
  file.directory:
    - mode: 0700
    - user: root
    - group: root

python-m2crypto:
  pkg.installed

{{tmpkey}}:
  x509.private_key_managed:
    - bits: 4096
    - require:
      - pkg: python-m2crypto
      - /etc/ssl/kibana

{{tmpcert}}:
  x509.certificate_managed:
    - signing_private_key: {{tmpkey}}
    - CN: {{grains['fqdn']}}
    - C: 'Estonia'
    - ST: 'Harjumaa'
    - L: 'Tallinn'
    - days_valid: 3650
    - days_remaining: 90
    - require:
      - {{tmpkey}}
      - pkg: python-m2crypto

{{vars['ssl.key']}}:
  file.managed:
    - mode: 0600
    - user: kibana
    - group: kibana
    - source: {{tmpkey}}
    - require:
      - {{vars['ssl.dir']}}
      - {{tmpkey}}

{{vars['ssl.cert']}}:
  file.managed:
    - mode: 0600
    - user: kibana
    - group: kibana
    - source: {{tmpcert}}
    - require:
      - {{vars['ssl.dir']}}
      - {{tmpcert}}
