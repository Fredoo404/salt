httpd:
  pkg.installed:
    - name: httpd

httpd.service:
  service.running:
    - enable: True
    - reload: True