install-python-pip:
  pkg.installed:
    - name: python-pip

shinken-user:
  user.present:
    - name: {{ pillar['shinken_user'] }}

install-shinken:
  pip.installed:
    - name: shinken

install-cherrypy:
  pip.installed:
    - name: cherrypy

install-common-require:
  pkg.installed:
    - pkgs:
      - python-crypto
      - mongodb
      - mongodb-server
      - httpd-tools
      - nagios-plugins

shinken-service:
  service.running:
    - name: shinken
    - enable: True
    - reload: True

arbiter-service:
  service.running:
    - name: shinken-arbiter
    - enable: True

poller-service:
  service.running:
    - name: shinken-poller
    - enable: True

reactionner-service:
  service.running:
    - name: shinken-reactionner
    - enable: True

scheduler-service:
  service.running:
    - name: shinken-scheduler
    - enable: True

broker-service:
  service.running:
    - name: shinken-broker
    - enable: True

receiver-service:
  service.running:
    - name: shinken-receiver
    - enable: True

mongod-service:
  service.running:
    - name: mongod
    - enbale: True

init-shinken:
  cmd.run:
    - name: shinken --init

simple-log-module:
  cmd.run:
    - name: shinken install simple-log

# Require for webui2:
#https://raw.githubusercontent.com/shinken-monitoring/mod-webui/develop/requirements.txt
webui2-require:
  pip.installed:
    - pkgs:
      - bottle==0.12.8
      - pymongo>=3.0.3
      - requests
      - arrow
      - passlib

webui2-module:
  cmd.run:
    - name: shinken install webui2

auth-secret-file:
  file.managed:
    - name: /var/lib/shinken/auth_secret
    - source: salt://shinken/files/auth_secret

webui2-config-file:
  file.managed:
    - name: /etc/shinken/modules/webui2.cfg
    - source: salt://shinken/files/webui2.cfg
    - watch_in: 
      - service: shinken-service

broker-config-file:
  file.managed:
    - name: /etc/shinken/brokers/broker-master.cfg
    - source: salt://shinken/files/broker-master.cfg
    - watch_in: 
      - service: shinken-service

variable-config-file:
  file.managed:
    - name: /etc/shinken/resource.d/paths.cfg
    - source: salt://shinken/files/paths.cfg
    - watch_in: 
      - service: shinken-service

commands-check-host-alive:
  file.managed:
    - name: /etc/shinken/commands/check_host_alive.cfg
    - source: salt://shinken/files/check_host_alive.cfg
    - watch_in: 
      - service: shinken-service