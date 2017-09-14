include:
  - kubernetes.kubectl

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

config_set_credentials_{{ worker }}:
  cmd.run:
    - name: kubectl config set-credentials system:node:{{ worker }} --client-certificate={{ worker }}.pem --client-key={{ worker }}-key.pem --embed-certs=true --kubeconfig={{ worker }}.kubeconfig

config_set_constext_{{ worker }}:
  cmd.run:
    - name: kubectl config set-context default --cluster={{ salt['pillar.get']('kubernetes:cluster_name') }} --user=system:node:{{ worker }} --kubeconfig={{ worker }}.kubeconfig

copy_{{ worker }}_certs_on_{{ worker }}:
  cmd.run:
    - name: 'salt-cp "{{ worker }}" /root/{{ worker }}*.kubeconfig /root/'

{% endfor %}