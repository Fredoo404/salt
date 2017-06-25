{% if grains['os'] == 'Debian' %}
prerequisite:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates
      - curl
      - gnupg2
      - software-properties-common

docker_repo:
  pkgrepo.managed:
    - humanname: Official Docker repository
    - name: "deb https://download.docker.com/linux/debian {{ grains['lsb_distrib_codename'] }} stable"
    - file: /etc/apt/sources.list.d/docker.list
    - gpgcheck: 1
    - key_url: https://download.docker.com/linux/debian/gpg

{% endif %}