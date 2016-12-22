#!/usr/bin/env python3

import json
import syslog

logs=[
    {
        'foo': 'bar',
        'baz': 'asd'
    },
    {
        'foo': 'baz',
        'lol': {
            'val': 'kek',
            'val2': "3"
        }
    }
]

for log in logs:
    msg = '@cee: %s' % (log)
    #msg = 'test'
    syslog.syslog(syslog.LOG_ERR, json.dumps(msg))
