/usr/local/bin/cfssl:
  file.managed:
    - source: https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
    - makedirs: True
    - skip_verify: True
    - mode: 755

/usr/local/bin/cfssljson:
  file.managed:
    - source: https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
    - makedirs: True
    - skip_verify: True
    - mode: 755
