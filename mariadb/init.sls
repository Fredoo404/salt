mariadb.packages:
  pkg.installed:
    - pkgs:
      - mariadb-server
      - mariadb
      - MySQL-python

mariadb.service:
  service.running:
    - name: mariadb
    - enable: True
    - reload: True