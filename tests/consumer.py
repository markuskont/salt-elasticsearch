#!/usr/bin/env python3
from kafka import KafkaConsumer
from elasticsearch import Elasticsearch

import json

INDEX='logs'
TYPE='events'
BULKSIZE=1024
PIPELINE='apache'


# To consume latest messages and auto-commit offsets
consumer = KafkaConsumer(INDEX,
                         bootstrap_servers=['localhost:9092'],
                         value_deserializer=lambda m: json.loads(m.decode('ascii')))

es = Elasticsearch(timeout=60)
es.indices.create(index=INDEX, ignore=400)

i = 0
count = 0
batch = []
for message in consumer:
    meta = {
        "index": {
            '_index': INDEX,
            '_type': TYPE
        }
    }
    source = message.value
    batch.append(json.dumps(meta))
    batch.append(json.dumps(source))
    if i % BULKSIZE == 0:
        batch = '\n'.join(batch)
        stats = es.bulk(body=batch, pipeline=PIPELINE)
        batch = []
        print('Bulk: ',i)
    i += 1
es.bulk(body=batch)
