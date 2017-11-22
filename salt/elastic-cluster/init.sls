elastic-cluster.master.setup:
  salt.state:
    - tgt: 'G@roles:elasticsearch and G@roles:master'
    - tgt_type: compound
    - sls: elastic-cluster.elasticsearch
    - saltenv: {{ saltenv }}

elastic-cluster.data.setup:
  salt.state:
    - tgt: 'G@roles:elasticsearch and G@roles:data'
    - tgt_type: compound
    - sls: elastic-cluster.elasticsearch
    - saltenv: {{ saltenv }}
    - require:
      - salt: elastic-cluster.master.setup

elastic-cluster.ingest.setup:
  salt.state:
    - tgt: 'G@roles:elasticsearch and G@roles:ingest'
    - tgt_type: compound
    - sls: elastic-cluster.elasticsearch
    - saltenv: {{ saltenv }}
    - require:
      - salt: elastic-cluster.master.setup
      - salt: elastic-cluster.data.setup

elastic-cluster.proxy.setup:
  salt.state:
    - tgt: 'G@roles:elasticsearch and G@roles:proxy'
    - tgt_type: compound
    - sls: elastic-cluster.elasticsearch
    - saltenv: {{ saltenv }}
    - require:
      - salt: elastic-cluster.master.setup
      - salt: elastic-cluster.data.setup

elastic-cluster.kibana.setup:
  salt.state:
    - tgt: 'G@roles:elasticsearch and G@roles:proxy'
    - tgt_type: compound
    - sls: elastic-cluster.kibana
    - saltenv: {{ saltenv }}
    - require:
      - salt: elastic-cluster.master.setup
      - salt: elastic-cluster.data.setup
      - salt: elastic-cluster.proxy.setup
