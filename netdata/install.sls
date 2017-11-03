netdata_download:
  file.managed:
    - name: /tmp/kickstart.sh
    - source: https://my-netdata.io/kickstart.sh
    - skip_verify: True

netdata_install:
  cmd.run:
    - name: "bash /tmp/kickstart.sh --dont-wait"
    - unless: "test -d /etc/netdata"