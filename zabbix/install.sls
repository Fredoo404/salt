include:
  - zabbix.repo

zabbix-install:
  pkg.installed:
    - pkgs:
      - zabbix-server-mysql
      - zabbix-web-mysql
      - zabbix-agent
      - zabbix-java-gateway
    - require:
      - pkgrepo: zabbix

zabbix.service:
  service.running:
    - name: zabbix-server
    - enable: True
    - reload: True

/etc/httpd/conf.d/zabbix.conf:
  file.managed:
    - source: salt://zabbix/files/zabbix.conf.j2
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: httpd
    - watch_in:
      - service: httpd.service

zabbixdb:
  mysql_database.present:
    - name: {{ pillar['zabbix_db'] }}
    - require:
      - pkg: mariadb.packages

zabbixuser:
  mysql_user.present: 
    - name: {{ pillar['zabbix_user'] }}
    - host: localhost
    - password: {{ pillar['zabbix_password'] }}
    - require:
      - pkg: mariadb.packages

zabbixgrant:
  mysql_grants.present:
    - grant: all privileges
    - database: '*.*'
    - user: {{ pillar['zabbix_user'] }}
    - require:
      - pkg: mariadb.packages

import-schema:
  cmd.run:
    - name: mysql -u "{{ pillar['zabbix_user'] }}" -p"{{ pillar['zabbix_password'] }}" -D "{{ pillar['zabbix_db'] }}" < /usr/share/doc/zabbix-server-mysql-2.4.8/create/schema.sql
    - require:
      - mysql_database: zabbixdb
      - mysql_user: zabbixuser
      - mysql_grants: zabbixgrant

import-image:
  cmd.run:
    - name: mysql -u "{{ pillar['zabbix_user'] }}" -p"{{ pillar['zabbix_password'] }}" -D "{{ pillar['zabbix_db'] }}" < /usr/share/doc/zabbix-server-mysql-2.4.8/create/images.sql
    - require:
      - cmd: import-schema

import-data:
  cmd.run:
    - name: mysql -u "{{ pillar['zabbix_user'] }}" -p"{{ pillar['zabbix_password'] }}" -D "{{ pillar['zabbix_db'] }}" < /usr/share/doc/zabbix-server-mysql-2.4.8/create/data.sql
    - require:
      - cmd: import-image

/etc/zabbix/zabbix_server.conf:
  file.managed:
    - source: salt://zabbix/files/zabbix_server.conf.j2
    - template: jinja
    - user: root
    - group: zabbix
    - mode: 640
    - watch_in:
      - service: zabbix.service
      - service: httpd.service

/etc/zabbix/zabbix_agentd.conf:
  file.managed:
    - source: salt://zabbix/files/zabbix_agentd.conf.j2
    - template: jinja
    - user: root
    - group: root
    - mode: 644

/etc/php.ini:
  file.managed:
    - source: salt://zabbix/files/php.ini.j2
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: httpd.service
