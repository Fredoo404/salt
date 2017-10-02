mine_functions:
  internal_ip:
    mine_function: cmd.run
    cmd: curl -s http://169.254.169.254/latest/meta-data/local-ipv4
  external_ip:
    mine_function: cmd.run
    cmd: curl -s http://169.254.169.254/latest/meta-data/public-ipv4
  machine_name:
    mine_function: network.get_hostname
kubernetes:
  version: 1.7.7
  cluster_name: 'Kubernetes'
  secret: 'itbeEYeMR2yFl7pPZ2WONIUIo2gZDS+ILmo0owUfcZw='
