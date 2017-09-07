{% set certs_caconfig = salt['pillar.get']('certs:caconfig') %}
{% set certs_cacsr = salt['pillar.get']('certs:cacsr') %}

/root/ca-config.json:
  file.managed:
    - source: salt://kubernetes/files/ca-config.json
    - template: jinja
    - defaults:
        certs: {{ salt['pillar.get']('certs') }}

/root/ca-csr.json:
  file.managed:
    - source: salt://kubernetes/files/ca-csr.json
    - template: jinja
    - defaults:
        certs: {{ salt['pillar.get']('certs') }}
    
