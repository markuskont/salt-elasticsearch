#!/usr/bin/env python3

from kafka import KafkaConsumer
import json

BULKSIZE=1024

# To consume latest messages and auto-commit offsets
consumer = KafkaConsumer('apache',
                         bootstrap_servers=['localhost:9092'],
                         value_deserializer=lambda m: json.loads(m.decode('ascii')))

i = 0
count = 0
batch = []
for message in consumer:
    source = message.value
    batch.append(json.dumps(source))
    if i % BULKSIZE == 0:
        print(batch[0])
        batch = []
    i += 1
