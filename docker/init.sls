{% if grains['os'] == 'Debian' %}
prerequisite:
  pkg.installed:
    pkgs:
      - apt-transport-https
      - ca-certificates
      - curl
      - gnupg2
      - software-properties-common

docker_repo:
  pkgrepo.managed:
    - humanname: Official Docker repository
    - mirrorlist: https://download.docker.com/linux/debian
    - gpgcheck: 1
    - gpgkey: https://download.docker.com/linux/debian/gpg

{% endif %}