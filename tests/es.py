#!/usr/bin/env python

import salt

def es_get_masters():
    masters = salt['saltutil.runner'](
        'mine.get',
        tgt='G@roles:master and G@roles:elasticsearch',
        fun='es_cluster_ip_addr',
        expr_form='compound')
    return masters

print es_get_masters()
