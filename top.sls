base:
  '*':
    - commo
    - zabbix.agent

  '*zabbix*':
    - apache
    - mariadb
    - zabbix

  '*salt-master*':
    - salt.master
