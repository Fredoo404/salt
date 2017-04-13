saltstack-repo:
  pkgrepo.managed:
    - humanname: SaltStack Latest Release Channel for RHEL/Centos $releasever
    - mirrorlist: https://repo.saltstack.com/yum/redhat/$releasever/$basearch/latest
    - gpgcheck: 1
    - gpgkey: https://repo.saltstack.com/yum/redhat/$releasever/$basearch/latest/SALTSTACK-GPG-KEY.pub

salt-master-pkg:
  pkg.installed:
    - name: salt-master

salt-master-service:
  service.running:
    - name: salt-master
    - enable: True
    - reload: True
    - watch:
      - file: /etc/salt/master

salt-master-configuration:
  file.managed:
    - name: /etc/salt/master
    - source: salt://salt/files/master