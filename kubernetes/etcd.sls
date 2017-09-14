{% set version = salt['pillar.get']('etcd:version') %}

retrieve_and_extract_etcd:
  archive.extracted:
    - name: /usr/local/sbin
    - source: https://github.com/coreos/etcd/releases/download/v{{ version }}/etcd-v{{ version }}-linux-amd64.tar.gz
    - skip_verify: True
    - enforce_toplevel: False
    - options: --strip-components=1 etcd-v3.2.6-linux-amd64/etcd etcd-v3.2.6-linux-amd64/etcdctl

/etc/etcd:
  file.directory

/var/lib/etcd:
  file.directory

/etc/etcd/ca.pem:
  file.copy:
    - source: /root/ca.pem

/etc/etcd/kubernetes-key.pem:
  file.copy:
    - source: /root/kubernetes-key.pem

/etc/etcd/kubernetes.pem:
  file.copy:
    - source: /root/kubernetes.pem

{% set config = [] %}
{% for server, addrs in salt['mine.get']('G@roles:controllers', 'internal_ip', 'compound').items() %}
{% do config.append(server+"=https://"+addrs+":2380") %}
{% endfor %}

/etc/systemd/system/etcd.service:
  file.managed:
    - source: salt://kubernetes/files/etcd.service
    - template: jinja
    - defaults: 
      hostname: {{ salt['grains.get']('id') }}
      ip: {{ salt['grains.get']('ip_interfaces:eth0') }}
      config: {{ config|join(',') }}

systemctl_daemon_reload:
  cmd.run:
    - name: systemctl daemon-reload

etcd:
  service.running:
    - enable: true

