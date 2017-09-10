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

  'G@roles:k8s-cli or G@roles:workers or G@roles:controllers':
    - match: compound
    - kubernetes
    
  'G@roles:k8s-cli':
    - kubernetes.certs