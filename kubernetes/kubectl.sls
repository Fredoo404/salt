/usr/local/bin/kubectl:
  file.managed:
    - source: https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubectl
    - makedirs: True
    - skip_verify: True
    - mode: 755

