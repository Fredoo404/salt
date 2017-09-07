{% set certs = salt['pillar.get']('certs') %}

/root/ca-config.json:
  file.managed:
    - source: salt://kubernetes/files/ca-config.json
    - template: jinja
    - defaults:
        certs: {{ certs }}

/root/ca-csr.json:
  file.managed:
    - source: salt://kubernetes/files/ca-csr.json
    - template: jinja
    - defaults:
        certs: {{ certs }}
    
