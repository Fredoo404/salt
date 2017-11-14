
{% if salt['grains.get']('roles') == 'controllers' %}
include:
  - kubernetes.kubectl

/root/encryption-config.yaml:
  file.managed:
    - source: salt://kubernetes/files/encryption-config.yaml
    - template: jinja
    - defaults:
      key: {{ salt['pillar.get']('kubernetes:secret') }}


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

/var/log/kube-apiserver.log:
  file.managed:
    - makedirs: True
    - content: 'log'

/etc/kubernetes/manifests/kube-apiserver.yaml:
  file.managed:
    - source: salt://kubernetes/files/kube-apiserver.yaml
    - template: jinja
    - makedirs: True
    - defaults:
      ip: {{ salt['grains.get']('ip_interfaces:eth0')[0] }}
      config: {{ config|join(',') }}

/var/log/kube-controller-manager.log:
  file.managed:
    - makedirs: True
    - content: 'log'

/etc/kubernetes/manifests/kube-controller-manager.yaml:
    - source: salt://kubernetes/files/kube-controller-manager.yaml
    - template: jinja
    - makedirs: True

/var/log/kube-scheduler.log:
  file.managed:
    - makedirs: True
    - content: 'log'

/etc/kubernetes/manifests/kube-scheduler.yaml:
    - source: salt://kubernetes/files/kube-scheduler.yaml
    - template: jinja
    - makedirs: True

{% endif %}
