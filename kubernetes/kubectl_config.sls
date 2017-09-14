include:
  - kubernetes.kubectl

{% set ip_lb = salt['mine.get']('G@roles:lb', 'external_ip', 'compound').values() %}
{% for worker in salt['mine.get']('G@roles:workers', 'machine_name', 'compound') %}

config_kubectl_{{ worker }}:
  cmd.run:
    - name: kubectl config set-cluster {{ salt['pillar.get']('kubernetes:cluster_name') }} --certificate-authority=ca.pem --embed-certs=true --server=https://{{ ip_lb }}:6443 --kubeconfig={{ worker }}.kubeconfig

copy_{{ worker }}_certs_on_{{ worker }}:
  cmd.run:
    - name: 'salt-cp "{{ worker }}" /root/{{ worker }}*.kubeconfig /root/'

{% endfor %}