base:
  '*':
    - common

  'zabbix-host':
    - apache
    - mariadb
    - zabbix
    - zabbix.agent