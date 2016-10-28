#!/usr/bin/env python

import subprocess
import yaml
import json

with open('/usr/local/bin/data.yml') as yml_file:
    config = yaml.load(yml_file)

for device_config in config['devices']:
    host = device_config['host']
    community = device_config['community']
    devicegroup = device_config['devicegroup']
    for metric_config in device_config['metrics']:
        oid = metric_config['oid']
        description = metric_config['description']
        units = metric_config['units']
        p = subprocess.Popen(['snmpget','-v','2c','-c',community,'-Ln','-OUt',host,oid],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE)
        out, err = p.communicate()
        obj = {'host': host, 'description': description, 'devicegroup': devicegroup, 'units': units, 'result': out.rstrip('\n')}
#       print(json.dumps(obj, separators=(', ',': ')))
        with open("/var/log/snmp", "a") as out:
            out.write(json.dumps(obj, separators=(', ',': '))+'\n')
