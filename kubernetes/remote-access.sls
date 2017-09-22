{% set ip_lb = salt['mine.get']('G@roles:lb', 'external_ip', 'compound').values() %}

kubectl-set-cluster:
  cmd.run:
    - name: kubectl config set-cluster kubernetes-the-hard-way --certificate-authority=ca.pem --embed-certs=true --server=https://{{ ip_lb[0] }}:6443
    - cwd: /root

kubectl-set-credentials:
  cmd.run:
    - name: kubectl config set-credentials admin --client-certificate=admin.pem --client-key=admin-key.pem
    - cwd: /root

kubectl-set-context:
  cmd.run:
    - name: kubectl config set-context {{ salt['pillar.get']('kubernetes:cluster_name') }} --cluster={{ salt['pillar.get']('kubernetes:cluster_name') }} --user=admin
    - cwd: /root

kubectl-use-context:
  cmd.run:
    - name: kubectl config use-context {{ salt['pillar.get']('kubernetes:cluster_name') }}
    - cwd: /root