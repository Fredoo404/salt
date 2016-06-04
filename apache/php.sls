php-install:
  pkg.installed:
    - pkgs:
      - php
      - php-mysql
      - php-gd
      - php-pear
  require:
    - pkg.installed: httpd