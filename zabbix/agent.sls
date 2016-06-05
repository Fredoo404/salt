include:
  - zabbix.repo

zabbix-agent:
  pkg.installed

zabbix-service:
  service.running:
    - name: zabbix-agent
    - enable: True
    - reload: True

/etc/zabbix/zabbix_agentd.conf:
  file.managed:
    - source: salt://zabbix/files/zabbix_agentd.conf.j2
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: zabbix-agent
    - watch_in:
      - service: zabbix-service
