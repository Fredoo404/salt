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

/etc/systemd/system/etcd.service:
  file.managed:
    - source: salt://etcd/files/etcd.service
    - template: jinja
    - defaults: 
      hostname: {{ salt['grains.get']('id') }}
      ip: {{ salt['grains.get']('ip_interfaces:eth0') }}
