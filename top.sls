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

  'G@roles:k8s-cli':
    - kubernetes.kubectl
    - kubernetes.certs
