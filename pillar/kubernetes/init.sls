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
  cluster_name: 'My kubernetes'
