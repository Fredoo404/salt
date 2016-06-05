epel:
  pkgrepo.managed:
    - humanname: Extra Packages for Enterprise Linux 7 - $basearch
    - mirrorlist: https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch
    - gpgcheck: 1
    - gpgkey: https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7 

zabbix:
  pkgrepo.managed:
    - humanname: Zabbix Official Repository - $basearch
    - baseurl: http://repo.zabbix.com/zabbix/2.4/rhel/7/$basearch/
    - enabled: 1
    - gpgcheck: 1
    - gpgkey: http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX