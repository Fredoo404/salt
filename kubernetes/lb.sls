/etc/haproxy/haproxy.cfg:
  file.managed:
    - source: salt://kubernetes/files/haproxy.conf
    - template: jinja
    - defaults:
      ip: {{ salt['grains.get']('ip_interfaces:eth0')[0] }}
    - watch_in:
      - service: service_haproxy
