
flatpak_repo:
  cmd.run:
    - name: "add-apt-repository -y ppa:alexlarsson/flatpak && apt-get update"

install_dependencies:
  pkg.installed:
    - pkgs:
      - socat 
      - libgpgme11 
      - libostree-1-1

/opt/cni/bin:
  file.directory

retrieve_and_extract_cni:
  archive.extracted:
    - name: /opt/cni/bin/
    - source: https://github.com/containernetworking/plugins/releases/download/v0.6.0/cni-plugins-amd64-v0.6.0.tgz
    - skip_verify: True
    - enforce_toplevel: False
    - options: -C

