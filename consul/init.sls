/root/test:
  file.managed:
    - source: salt://consul/files/test.j2
    - template: jinja
    - skip_verify: True