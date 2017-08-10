include:
  - nginx
  - fastcgi
  - sendmail

smokeping:
  pkg:
    - installed
  service.running:
    - enable: True
    - reload: True

/var/www/smokeping:
  file.symlink:
    - target: /usr/share/smokeping/www

/var/www/smokeping/smokeping.cgi:
  file.symlink:
    - target: /usr/lib/cgi-bin/smokeping.cgi

/etc/smokeping/config.d/pathnames:
  file.managed:
    - source: salt://smokeping/files/pathnames.j2
    - template: jinja
    - skip_verify: True

/etc/nginx/conf.d/smokeping.conf:
  file.managed:
    - source: salt://smokeping/files/smokeping.conf.j2
    - template: jinja
    - makedirs: True
    - skip_verify: True
    - defaults:
      servername: {{ salt['pillar.get']('servername', 'smokeping') }}
    - watch_in:
      - service: nginx
