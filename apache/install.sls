httpd:
  pkg.installed:
    - name: httpd
  service.running:
    - enable: True
    - reload: True