include:
  - cfssl

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
    
