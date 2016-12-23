#!/usr/bin/env python3

import sys
from elasticsearch import Elasticsearch
import csv, json

import asyncio
import requests

JSON_PATH = '/vagrant/data/apache.log.1'

BULKSIZE=300

INDEX='apache-2016.12'
TYPE='logs'
PIPELINE='apache'
TPL= {
    "settings" : {
        "number_of_shards" : 1,
        "number_of_replicas" : 0
    }
}

@asyncio.coroutine
def main():

    es = Elasticsearch(timeout=60)
    es.indices.create(index=INDEX, ignore=400)

    loop = asyncio.get_event_loop()

    with open(JSON_PATH) as f:
        i = 0
        count = 0
        batch = []
        for line in f:
            meta = {
                "index": {
                    '_index': INDEX,
                    '_type': TYPE
                }
            }
            source = {
                'message': line
            }
            batch.append(json.dumps(meta))
            batch.append(json.dumps(source))
            batch.append(json.dumps(meta))
            batch.append(json.dumps(source))
            if i % BULKSIZE == 0:
                batch = '\n'.join(batch)
                #response = es.bulk(body=batch, pipeline=PIPELINE)
                response = yield from loop.run_in_executor(None, es.bulk, batch)
                print(response)
                batch = []
                #print('Wrote: ',response)
                print('Bulk: ',i)
            i += 1
        es.bulk(body=batch, pipeline=PIPELINE)

loop = asyncio.get_event_loop()
loop.run_until_complete(main())
