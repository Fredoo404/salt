include:
  - nginx
  - fastcgi

smokeping:
  pkg.installed

/usr/share/smokeping/www:
  file.symlink:
    - target: /var/www/smokeping

/usr/lib/cgi-bin/smokeping.cgi:
  file.symlink:
    - target: /var/www/smokeping

/var/www/smokeping:
  file.symlink:
    - target: /usr/share/smokeping/www

/var/www/smokeping/smokeping.cgi:
  file.symlink:
    - target: /usr/lib/cgi-bin/smokeping.cgi
