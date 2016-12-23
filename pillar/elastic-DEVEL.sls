elasticsearch:
  cluster.name: 'josephine'
  path.logs: '/var/log/elasticsearch'
  path.data: '/srv/elasticsearch'

kibana:
  manage.tls: true
  ssl.dir: '/etc/kibana/ssl'
  ssl.cert: '/etc/kibana/ssl/cert.pem'
  ssl.key: '/etc/kibana/ssl/key.pem'

kafka:
  manage: true
  home: /opt/kafka
  version: '0.10.1.0'
