#!/usr/bin/env python3
from kafka import KafkaConsumer
from elasticsearch import Elasticsearch

import json

# to make things explicit
LOG='apache'
ES_INDEX=LOG
ES_PIPELINE=LOG
KAFKA_TOPIC=LOG

ES_TYPE='events'

BULKSIZE=1024

# To consume latest messages and auto-commit offsets
consumer = KafkaConsumer(KAFKA_TOPIC,
                         bootstrap_servers=['localhost:9092'],
                         value_deserializer=lambda m: json.loads(m.decode('ascii')))

es = Elasticsearch(timeout=60)
es.indices.create(index=ES_INDEX, ignore=400)

i = 0
count = 0
batch = []
for message in consumer:
    meta = {
        "index": {
            '_index': ES_INDEX,
            '_type': ES_TYPE,
            'pipeline': ES_PIPELINE
        }
    }
    source = message.value
    batch.append(json.dumps(meta))
    batch.append(json.dumps(source))
    if i % BULKSIZE == 0:
        batch = '\n'.join(batch)
        stats = es.bulk(body=batch)
        batch = []
        print('Bulk: ',stats)
    i += 1
es.bulk(body=batch)
