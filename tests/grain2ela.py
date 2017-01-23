#!/usr/bin/env python

# apt-get install python-pip
# pip install elasticsearch

import sys, json, argparse, time, hashlib
import salt.client
from elasticsearch import Elasticsearch

def parse_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument('-es','--elasticsearch', nargs='+', required=False, default=['localhost'])
    parser.add_argument('-i', '--index', default='inventory')
    parser.add_argument('-t', '--type', default='grains')
    parser.add_argument('-p', '--pipeline', default=None)
    return parser.parse_args()

ARGS = parse_arguments()
HOSTS=ARGS.elasticsearch
INDEX=ARGS.index
TYPE=ARGS.type
PIPELINE=ARGS.pipeline

SALT_TIMEOUT=60

# these indices will be small. Go for full redundancy
# Salt grains can contain arrays with different mappings, e.g. ['2', '7', '8', 'final']
# Not supported by elastic
TEMPLATE= {
  "order" : 10,
  "version" : 0,
  "template" : "inventory-*",
  "settings" : {
    "index" : {
      "refresh_interval" : "60s",
      "number_of_shards" : 1,
      "number_of_replicas" : 8
    }
  },
  "mappings" : {
  "_default_" : {
    "properties" : {
      "pythonversion": {
        "type": "text",
        "fields": {
              "keyword": {
              "type": "keyword",
              "ignore_above": 256
            }
          }
        }
      }
    }
  },
  "aliases" : { }
}

def saltQuery():
    return salt.client.LocalClient().cmd(
        tgt='*',
        fun='grains.items',
        expr_form='glob',
        timeout=SALT_TIMEOUT
)

def main():
    es = Elasticsearch(hosts=HOSTS, timeout=60)
    #es.put_template(id=INDEX, body=TEMPLATE)

    timestamp = int(round(time.time()))

    grains = saltQuery()
    bulk = []
    timeseries = "%s-%s" % (INDEX, time.strftime('%Y', time.localtime(timestamp)))
    latest = "%s-latest" % (INDEX)

    for host, data in grains.items():
        # migration from puppet to salt, duplicate data
        if 'facter' in data: del data['facter']
        meta = {
            "index": {
                "_index": timeseries,
                "_type": TYPE
            }
        }
        data['@timestamp'] = timestamp * 1000

        # create immutable log of historical data (dynamic ID)
        bulk.append(json.dumps(meta))
        bulk.append(json.dumps(data))

        # create mutable report of current (static ID)
        # fqdn is already a unique id for saltstack, thus good enough for ES
        # also use different index
        meta['index']['_id'] = data['fqdn']
        meta['index']['_index'] = latest

        bulk.append(json.dumps(meta))
        bulk.append(json.dumps(data))

    ## Debug
    # for item in bulk:
    #     print item
    
    # push bulk to ES
    print json.dumps(es.bulk(body=bulk), sort_keys=True, indent=2)

if __name__ == '__main__':
    main()
