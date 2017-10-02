
{% if salt['grains.get']('roles') == 'controllers' %}
include:
  - kubernetes.kubectl

/root/encryption-config.yaml:
  file.managed:
    - source: salt://kubernetes/files/encryption-config.yaml
    - template: jinja
    - defaults:
      key: {{ salt['pillar.get']('kubernetes:secret') }}

/usr/local/bin/kube-apiserver:
  file.managed:
    - source: https://storage.googleapis.com/kubernetes-release/release/v{{ salt['pillar.get']('kubernetes:version') }}/bin/linux/amd64/kube-apiserver
    - skip_verify: True
    - mode: 755
    - replace: False

/usr/local/bin/kube-controller-manager:
  file.managed:
    - source: https://storage.googleapis.com/kubernetes-release/release/v{{ salt['pillar.get']('kubernetes:version') }}/bin/linux/amd64/kube-controller-manager
    - skip_verify: True
    - mode: 755
    - replace: False

/usr/local/bin/kube-scheduler:
  file.managed:
    - source: https://storage.googleapis.com/kubernetes-release/release/v{{ salt['pillar.get']('kubernetes:version') }}/bin/linux/amd64/kube-scheduler
    - skip_verify: True
    - mode: 755
    - replace: False

/var/lib/kubernetes/ca.pem:
  file.copy:
    - source: /root/ca.pem
    - makedirs: True

/var/lib/kubernetes/ca-key.pem:
  file.copy:
    - source: /root/ca-key.pem
    - makedirs: True

/var/lib/kubernetes/kubernetes.pem:
  file.copy:
    - source: /root/kubernetes.pem
    - makedirs: True

/var/lib/kubernetes/kubernetes-key.pem:
  file.copy:
    - source: /root/kubernetes-key.pem
    - makedirs: True

/var/lib/kubernetes/encryption-config.yaml:
  file.copy:
    - source: /root/encryption-config.yaml
    - makedirs: True

{% set config = [] %}
{% for server, addrs in salt['mine.get']('G@roles:controllers', 'internal_ip', 'compound').items() %}
{% do config.append("https://"+addrs+":2379") %}
{% endfor %}

/etc/systemd/system/kube-apiserver.service:
  file.managed:
    - source: salt://kubernetes/files/kube-apiserver.service
    - template: jinja
    - defaults:
      ip: {{ salt['grains.get']('ip_interfaces:eth0')[0] }}
      config: {{ config|join(',') }}

/etc/systemd/system/kube-controller-manager.service:
  file.managed:
    - source: salt://kubernetes/files/kube-controller-manager.service
    - template: jinja
    - defaults:
      ip: {{ salt['grains.get']('ip_interfaces:eth0')[0] }}
 
/etc/systemd/system/kube-scheduler.service:
  file.managed:
    - source: salt://kubernetes/files/kube-scheduler.service
    - template: jinja
    - defaults:
      ip: {{ salt['grains.get']('ip_interfaces:eth0')[0] }}

systemctl_daemon_reload:
  cmd.run:
    - name: systemctl daemon-reload

kube-apiserver:
  service.running:
    - enable: True
    - reload: True

kube-controller-manager:
  service.running:
    - enable: True
    - reload: True

kube-scheduler:
  service.running:
    - enable: True
    - reload: True

{% endif %}
