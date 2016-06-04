epel:
  pkgrepo.managed:
    - humanname: Extra Packages for Enterprise Linux 7 - $basearch
    - mirrorlist: https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch
    - gpgcheck: 1
    - gpgkey: https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7 