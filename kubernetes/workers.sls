
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
  file.directory:
    - makedirs: True

retrieve_and_extract_cni:
  archive.extracted:
    - name: /opt/cni/bin/
    - source: https://github.com/containernetworking/plugins/releases/download/v0.6.0/cni-plugins-amd64-v0.6.0.tgz
    - archive_format: tar
    - skip_verify: True
    - enforce_toplevel: False

retrieve_and_extract_runc:
  archive.extracted:
    - name: /usr/local/bin/runc
    - source: https://github.com/opencontainers/runc/releases/download/v1.0.0-rc4/runc.amd64
    - skip_verify: True
    - enforce_toplevel: False
