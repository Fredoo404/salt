include:
  - kubernetes.kubectl

#############################################################
#
# Generate Kubectl configuration for kube proxy.
#
#############################################################

config_set_cluster_kubeproxy:
  cmd.run:
    - name: kubectl config set-cluster {{ salt['pillar.get']('kubernetes:cluster_name') }} --certificate-authority=ca.pem --embed-certs=true --server=https://{{ ip_lb[0] }}:6443 --kubeconfig=kube-proxy.kubeconfig
    - cwd: /root

config_set_credentials_kubeproxy:
  cmd.run:
    - name: kubectl config set-credentials kube-proxy --client-certificate=kube-proxy.pem --client-key=kube-proxy-key.pem --embed-certs=true --kubeconfig=kube-proxy.kubeconfig
    - cwd: /root

config_set_context_kubeproxy:
  cmd.run:
    - name: kubectl config set-context default --cluster={{ salt['pillar.get']('kubernetes:cluster_name') }} --user=kube-proxy --kubeconfig=kube-proxy.kubeconfig
    - cwd: /root

config_use_context_kubeproxy:
  cmd.run:
    - name: kubectl config use-context default --kubeconfig=kube-proxy.kubeconfig
    - cwd: /root

#############################################################
#
# Generate Kubectl configuration for workers.
#
#############################################################

{% set ip_lb = salt['mine.get']('G@roles:lb', 'external_ip', 'compound').values() %}
{% for worker in salt['mine.get']('G@roles:workers', 'machine_name', 'compound') %}

config_set_cluster_kubectl_{{ worker }}:
  cmd.run:
    - name: kubectl config set-cluster {{ salt['pillar.get']('kubernetes:cluster_name') }} --certificate-authority=ca.pem --embed-certs=true --server=https://{{ ip_lb[0] }}:6443 --kubeconfig={{ worker }}.kubeconfig
    - cwd: /root

config_set_credentials_{{ worker }}:
  cmd.run:
    - name: kubectl config set-credentials system:node:{{ worker }} --client-certificate={{ worker }}.pem --client-key={{ worker }}-key.pem --embed-certs=true --kubeconfig={{ worker }}.kubeconfig
    - cwd: /root

config_set_context_{{ worker }}:
  cmd.run:
    - name: kubectl config set-context default --cluster={{ salt['pillar.get']('kubernetes:cluster_name') }} --user=system:node:{{ worker }} --kubeconfig={{ worker }}.kubeconfig
    - cwd: /root

config_use_context_{{ worker }}:
  cmd.run:
    - name: kubectl config use-context default --kubeconfig={{ worker }}.kubeconfig
    - cwd: /root

copy_{{ worker }}_kubectl_on_{{ worker }}:
  cmd.run:
    - name: 'salt-cp "{{ worker }}" /root/{{ worker }}*.kubeconfig /root/'

copy_kubeproxy_kubectl_on_{{ worker }}:
  cmd.run:
    - name: 'salt-cp "{{ worker }}" /root/kube-proxy.kubeconfig /root/'

{% endfor %}

