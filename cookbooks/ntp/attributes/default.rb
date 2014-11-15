#Attributes for ntp cookbook RHEL/Centos
#Default setup here, will be overiden in environments

default[:ntp][:subnet]='192.168.1.0'
default[:ntp][:netmask]='255.255.255.0'

default[:ntp][:server0]='0.centos.pool.ntp.org'
default[:ntp][:server1]='1.centos.pool.ntp.org'
default[:ntp][:server2]='2.centos.pool.ntp.org'
default[:ntp][:server3]='3.centos.pool.ntp.org'
