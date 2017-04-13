base:
  '*':
    - common
    - zabbix.agent

  '*zabbix*':
    - apache
    - mariadb
    - zabbix
