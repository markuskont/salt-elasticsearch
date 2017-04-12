#!/usr/bin/env python

import socket
import yaml
import subprocess

hostname = socket.gethostname()
grains = {
    'roles': [ 'elasticsearch' ]
}
command = ['service', 'salt-minion', 'restart']

if '-master-' in hostname:
    grains['roles'].append('master')
if '-data-' in hostname:
    grains['roles'].append('data')
    grains['roles'].append('ingest')
if '-gw-' in hostname:
    grains['roles'].append('gateway')
if '-proxy-' in hostname:
    grains['roles'].append('proxy')

with open('/etc/salt/grains', 'w') as outfile:
    yaml.dump(grains, outfile, default_flow_style=False)

subprocess.call(command, shell=False)
