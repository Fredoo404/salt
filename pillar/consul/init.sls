mine_functions:
  internal_ip:
    mine_function: network.ip_addrs
    interface: eth0
consul:
  version: 0.8.5
  config:
    bind_addr: 0.0.0.0
    data_dir: /var/consul
    log_level: info
    enable_syslog: false
    enable_debug: false
    rejoin_after_leave: true
    encrypt: "xxxxxxxxxxxxxxxxxxxxxxxx"
    retry_join: 
      - ip1
      - ip2
      - ip3
    server: false
    services:
      - name: service_test
