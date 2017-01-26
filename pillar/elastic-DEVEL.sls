# some params, such as node, are only defaults and will be overwritten based on roles
elasticsearch:
  config:
    cluster:
      name: 'josephine'
    path:
      logs: '/var/log/elasticsearch'
      data:
        - '/srv/elasticsearch/0'
        - '/srv/elasticsearch/1'
    node:
      name: {{grains['fqdn']}}
      master: false
      data: false
      ingest: false
    http:
      enabled: true
      host: 127.0.0.1
    discovery:
      zen:
        ping:
          unicast:
            hosts:
              - 192.168.56.170
    network:
      host: 0.0.0.0

kibana:
  manage.tls: true
  ssl.dir: '/etc/kibana/ssl'
  ssl.cert: '/etc/kibana/ssl/cert.pem'
  ssl.key: '/etc/kibana/ssl/key.pem'

kafka:
  manage: true
  user: 'kafka'
  home: '/opt/kafka'
  logdir: '/var/log/kafka'
  confdir: '/etc/kafka'
  version: '0.10.1.0'

rsyslog-gateway:
  ruledir: '/opt/lognorm'
