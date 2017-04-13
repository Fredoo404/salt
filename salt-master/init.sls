saltstack-repo:
  pkgrepo.managed:
    - humanname: SaltStack Latest Release Channel for RHEL/Centos $releasever
    - mirrorlist: https://repo.saltstack.com/yum/redhat/$releasever/$basearch/latest
    - gpgcheck: 1
    - gpgkey: https://repo.saltstack.com/yum/redhat/$releasever/$basearch/latest/SALTSTACK-GPG-KEY.pub

salt-master:
  pkg.installed

salt-master:
  service.running:
    - enable: True
    - reload: True
    - watch:
      - file: /etc/salt/master

/etc/salt/master:
  file.managed:
    - source: salt://salt-master/files/master