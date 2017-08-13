
unzip:
  pkg.installed

/usr/local/bin:
  file.directory:
    - makedirs: True

consul:
  user:
    - present
  group.present:
    - system: True
    - addusers:
      - consul
  file.managed:
    - name: /home/consul/consul.zip
    - source: https://releases.hashicorp.com/consul/0.9.2/consul_0.9.2_linux_amd64.zip

/root/test:
  file.managed:
    - source: salt://consul/files/test.j2
    - template: jinja
    - skip_verify: True