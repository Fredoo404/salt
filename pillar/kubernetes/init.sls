mine_functions:
  internal_ip:
    mine_function: network.ip_addrs
    interface: eth0
  external_ip:
    mine_function: cmd.run
    cmd: curl -s http://169.254.169.254/latest/meta-data/public-ipv4
