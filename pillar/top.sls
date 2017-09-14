base:
  '*':
    - common

  '*zabbix*':
    - zabbix

  '*shinken*':
    - shinken

  '*smokeping*':
    - smokeping

  '*consul* and G@roles:server':
    - match: compound
    - consul
    - consul.server

  '*consul* and G@roles:agent':
    - match: compound
    - consul
    - consul.services.test1

  '*etcd* and G@roles:server':
    - etcd

  'G@roles:k8s-cli or G@roles:workers or G@roles:controllers or G@roles:lb':
    - match: compound
    - kubernetes
    
  'G@roles:k8s-cli':
    - kubernetes.certs

  'G@roles:controllers':
    - etcd