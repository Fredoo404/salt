base:
  '*':
    - common
    - zabbix.agent

  'zabbix-host':
    - apache
    - mariadb
    - zabbix
