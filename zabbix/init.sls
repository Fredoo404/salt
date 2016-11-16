{% from "map.jinja" import config with context %}
include:
  - apache
  - mariadb
  - zabbix.install