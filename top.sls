base:
  '*':
    - common
    - zabbix.agent

  '*zabbix*':
    - apache
    - mariadb
    - zabbix

  '*salt-master*':
    - salt.master
