
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

/root/test:
  file.managed:
    - source: salt://consul/files/test.j2
    - template: jinja
    - skip_verify: True