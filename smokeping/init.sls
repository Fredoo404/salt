include:
  - nginx
  - fastcgi

smokeping:
  pkg.installed

/var/www/smokeping:
  file.symlink:
    - target: /usr/share/smokeping/www

/var/www/smokeping/smokeping.cgi:
  file.symlink:
    - target: /usr/lib/cgi-bin/smokeping.cgi

/etc/nginx/conf.d/smokeping.conf:
  file.managed:
    - source: source://smokeping/files/smokeping.conf.j2
    - template: jinja
    - makedirs: True
    - skip_verify: True
    - defaults:
      servername: {{ salt['pillar.get']('servername', 'smokeping') }}
