include:
  - cfssl

#############################################################
#
# Generate Ca certs.
#
#############################################################

/root/ca-config.json:
  file.managed:
    - source: salt://kubernetes/files/ca-config.json.j2
    - template: jinja
    - defaults:
      certs: {{ salt['pillar.get']('certs:ca-config') }}

/root/ca-csr.json:
  file.managed:
    - source: salt://kubernetes/files/ca-csr.json.j2
    - template: jinja
    - defaults:
      certs: {{ salt['pillar.get']('certs:ca-csr') }}

generate_ca_cert:
  cmd.run:
    - name: cfssl gencert -initca ca-csr.json | cfssljson -bare ca
    - cwd: /root
    
copy_ca_certs_on_controllers:
  cmd.run:
    - name: 'salt-cp -G "roles:controllers" /root/ca*.pem /root/'

copy_ca_certs_on_workers:
  cmd.run:
    - name: 'salt-cp -G "roles:workers" /root/ca*.pem /root/'

#############################################################
#
# Generate Admin certs.
#
#############################################################

/root/admin-csr.json:
  file.managed:
    - source: salt://kubernetes/files/admin-csr.json.j2
    - template: jinja
    - defaults:
      certs: {{ salt['pillar.get']('certs:admin-csr') }}

generate_admin_cert:
  cmd.run:
    - name: cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes admin-csr.json | cfssljson -bare admin
    - cwd: /root

#############################################################
#
# Generate Kubelet certs.
#
#############################################################

{% set certs = salt['pillar.get']('certs') %}
{% for worker in salt['mine.get']('G@roles:workers', 'machine_name', 'compound') %}
{% do certs['worker-csr'].update({'CN':'system:node:' + worker }) %}
{% set private_ip = salt['mine.get'](worker, 'internal_ip') %}
{% set public_ip = salt['mine.get'](worker, 'external_ip') %}

/root/{{ worker }}-csr.json:
  file.managed:
    - source: salt://kubernetes/files/json_file.j2
    - template: jinja
    - defaults:
      certs: {{ certs['worker-csr'] }}

generate_{{ worker }}_cert:
  cmd.run:
    - name: cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -hostname={{ worker }},{{ private_ip[worker][0] }},{{ public_ip[worker] }} -profile=kubernetes {{ worker }}-csr.json | cfssljson -bare {{ worker }}
    - cwd: /root
{% endfor %}

#############################################################
#
# Generate Kube-proxy certs.
#
#############################################################

/root/kube-proxy-csr.json:
  file.managed:
    - source: salt://kubernetes/files/json_file.j2
    - template: jinja
    - defaults:
      certs: {{ salt['pillar.get']('certs:kubeproxy-csr') }}

generate_kube_proxy_cert:
  cmd.run:
    - name: cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes kube-proxy-csr.json | cfssljson -bare kube-proxy
    - cwd: /root
