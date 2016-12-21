{% set tpl = 'default' %}

/tmp/{{tpl}}.json:
  file.managed:
    - source: salt://elasticsearch/etc/elasticsearch/template/{{tpl}}.tpl
    - mode: 644

create_{{tpl}}_template:
  cmd.run:
    - name: curl -ss -k -XPUT localhost:9200/_template/{{tpl}} -d @/tmp/{{tpl}}.json
    - unless:  curl -ss -k -XGET localhost:9200/_template/{{tpl}} | python3 -c "import sys, json; file = \"/tmp/{{tpl}}.json\"; f = open(file, 'r'); disk = json.load(f); es = json.load(sys.stdin); sys.exit(1) if \"{{tpl}}\" not in es else None"
