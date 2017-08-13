{% set consul = salt['pillar.get']('consul') %}
{% do consul['config'].update({'bind_addr': salt['grains.get']('ip_interfaces:eth0')[0]}) %}
{% if salt['grains.get']('roles', None) %}
{% do consul['config'].update({'server': true}) %}
{% endif %}
{% for server, addrs in salt['mine.get']('G@roles:server', 'internal_ip', 'compound').items() %}
{% do consul['config']['retry_join'].append(addrs[0]) %}
{% endfor %}

consul:
  user:
    - present
  group.present:
    - system: True
    - addusers:
      - consul
  archive.extracted:
    - name: /usr/local/sbin
    - source: https://releases.hashicorp.com/consul/{{ consul.version }}/consul_{{ consul.version }}_linux_amd64.zip
    - skip_verify: True
    - enforce_toplevel: False
  file.managed:
    - name: /etc/consul.d/config.json
    - source: salt://consul/files/config.json.j2
    - makedirs: True
    - template: jinja
    - skip_verify: True
    - defaults:
      consul: {{ consul }}

{% if salt['test.provider']('service') == 'systemd' %}
/etc/systemd/system/consul.service:
  file.managed:
    - source: salt://consul/files/consul.service
    - skip_verify: True
{% endif %}

/var/consul:
  file.directory:
    - user: consul
    - group: consul
    - mode: 755
    - makedirs: True

consul_service:
  service.running:
    - name: consul
    - enable: True

