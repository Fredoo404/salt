/usr/local/bin/kubectl:
  file.managed:
    - source: https://storage.googleapis.com/kubernetes-release/release/v{{ salt['pillar.get']('kubernetes:version') }}/bin/linux/amd64/kubectl
    - makedirs: True
    - skip_verify: True
    - mode: 755
    - replace: False

