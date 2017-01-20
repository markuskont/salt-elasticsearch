#!/usr/bin/env python

# apt-get install python-pip
# pip install elasticsearch

import sys, json, argparse, time
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

TEMPLATE= {
 "order" : 10,
 "version" : 0,
 "template" : "inventory-*",
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
    es.indices.create(index=INDEX, ignore=400)
    #es.put_template(id=INDEX, body=TEMPLATE)

    timestamp = int(round(time.time()))

    grains = saltQuery()
    bulk = []
    index = "%s-%s" % (INDEX, time.strftime('%Y', time.localtime(timestamp)))

    # migration from puppet to salt, duplicate data

    for host, data in grains.items():
        if 'facter' in data: del data['facter']
        meta = {
            "index": {
                "_index": index,
                "_type": TYPE
            }
        }
        data['@timestamp'] = timestamp * 1000
        bulk.append(json.dumps(meta))
        bulk.append(json.dumps(data))

    print json.dumps(es.bulk(body=bulk), sort_keys=True, indent=2)

if __name__ == '__main__':
    main()
