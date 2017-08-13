consul:
  user:
    - present
  group.present:
    - system: True
    - addusers:
      - consul
  archive.extracted:
    - name: /usr/local/sbin/consul
    - source: https://releases.hashicorp.com/consul/0.9.2/consul_0.9.2_linux_amd64.zip
    - skip_verify: True
    - enforce_toplevel: False
  file.managed:
    - name: /etc/consul.d/config.json
    - source: salt://consul/files/config.json.j2
    - makedirs: True
    - template: jinja
    - skip_verify: True
    - defaults:
      consul: {{ salt['pillar.get']('consul') }}
      consul_server_ip: {{ salt['mine.get']('G@roles:consul-server', 'internal_ip', 'compound').values }}