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
