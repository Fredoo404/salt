service_haproxy:
  service.running:
    - name: haproxy
    - enable: True
    - reload: True
