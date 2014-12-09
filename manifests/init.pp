# == Class: role_snmp
#
# Full description of class role_snmp here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'role_snmp':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class role_snmp {

  # Configure snmp using module razorsedge/snmp.
  class { 'snmp::client':
    snmp_config => [ 'mibdirs +/usr/local/share/snmp/mibs/hp/mibs-Oct2014',
                     'mibdirs +/usr/local/share/snmp/mibs/apc',
                     'mibs ALL',
                   ],
  }

  # Extract HP mib files using module camptocamp/puppet-archive. Download from https://h10145.www1.hp.com/Downloads/SoftwareReleases.aspx?ProductNumber=J9148A&lang=nl&cc=nl&prodSeriesId=1839466
  archive { 'hp':
    ensure   => present,
    url      => 'https://raw.githubusercontent.com/naturalis/puppet-role_snmp/master/files/mibs-Oct2014.tar.gz',
    target   => '/usr/local/share/snmp/mibs/hp',
    checksum => false,
    require  => Class ['snmp::client'],
  }
  
   # Extract APC mib files using module camptocamp/puppet-archive. Download from ftp://ftp.apc.com/apc/public/software/pnetmib/mib/412/powernet412.mib
  archive { 'apc':
    ensure   => present,
    url      => 'https://raw.githubusercontent.com/naturalis/puppet-role_snmp/master/files/powernet412.mib.tar.gz',
    target   => '/usr/local/share/snmp/mibs/apc',
    checksum => false,
    require  => Class ['snmp::client'],
  }
  
}
