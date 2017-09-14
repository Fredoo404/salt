
{% if salt['grains.get']('roles') == 'controllers' %}

/root/encryption-config.yaml:
  file.managed:
    - source: salt://kubernetes/files/encryption-config.yaml
    - template: jinja
    - defaults:
      key: {{ salt['pillar.get']('kubernetes:secret') }}

{% endif %}
