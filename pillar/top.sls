base:
  '*':
    - common

  '*zabbix*':
    - zabbix

  '*shinken*':
    - shinken

  '*smokeping*':
    - smokeping

  'G@roles:consul-server':
    - consul
    - consul.server