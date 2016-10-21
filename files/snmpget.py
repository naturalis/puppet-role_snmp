#!/usr/bin/env python

import subprocess
import yaml
import json

with open('data.yml') as yml_file:
    config = yaml.load(yml_file)

for device_config in config['devices']:
    host = device_config['host']
    community = device_config['community']
    devicegroup = device_config['devicegroup']
    for metric_config in device_config['metrics']:
        oid = metric_config['oid']
        description = metric_config['description']
        p = subprocess.Popen(['snmpwalk','-v','2c','-c',community,'-Ln','-OUt',host,oid],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE)
        out, err = p.communicate()
        obj = {'host': host, 'description': description, 'devicegroup': devicegroup, 'result': out.rstrip('\n')}
        print(json.dumps(obj, separators=(', ',': ')))
