{% set vars = pillar['kafka'] %}

kafka:
  group.present:
    - name: kafka
  user.present:
    - gid_from_name: True
    - home: {{vars['home']}}
    - shell: '/bin/false'
    - groups:
      - kafka
    - require:
      - {{vars['home']}}

{{vars['home']}}:
  file.directory:
    - user: kafka
    - group: kafka
    - mode: 755
/var/log/kafka:
  file.directory:
    - user: kafka
    - group: kafka
    - mode: 750

zookeeperd:
  pkg.installed

get-kafka-pacakge:
  cmd.run:
    - name: wget -O kafka-{{vars['version']}}.tgz http://www-us.apache.org/dist/kafka/{{vars['version']}}/kafka_2.11-{{vars['version']}}.tgz
    - creates: {{vars['home']}}/kafka-{{vars['version']}}.tgz
    - cwd: {{vars['home']}}
    - require:
      - {{vars['home']}}

set-kafka-package:
  cmd.run:
    - name: tar -xzf kafka-{{vars['version']}}.tgz -C {{vars['home']}}
    - creates: {{vars['home']}}/kafka-2.11-{{vars['version']}}/bin/kafka-server-start.sh
    - cwd: {{vars['home']}}
    - require:
      - cmd: get-kafka-pacakge
