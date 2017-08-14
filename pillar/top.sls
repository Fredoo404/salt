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