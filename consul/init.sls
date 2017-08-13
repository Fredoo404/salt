
unzip:
  pkg.installed

/usr/local/bin:
  file.directory:
    - makedirs: True

consul:
  user:
    - present
  group.present:
    - createhome: False
    - system: True
    - groups:
      - consul

/root/test:
  file.managed:
    - source: salt://consul/files/test.j2
    - template: jinja
    - skip_verify: True