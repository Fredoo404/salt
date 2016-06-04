mariadb.packages:
  pkg.installed:
    - pkgs:
      - mariadb-server
      - mariadb
  service.running:
    - name: mariadb
    - enable: True