
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

retrieve_runc:
  file.managed:
    - name: /usr/local/bin/runc
    - source: https://github.com/opencontainers/runc/releases/download/v1.0.0-rc4/runc.amd64
    - mode: 755
    - skip_verify: True
    - replace: False

retrieve_and_extract_crio:
  archive.extracted:
    - name: /usr/local/bin
    - source: https://storage.googleapis.com/kubernetes-the-hard-way/crio-amd64-v1.0.0-beta.0.tar.gz
    - archive_format: tar
    - skip_verify: True
    - enforce_toplevel: False
    
copy_conmon:
  file.copy:
    - name: /usr/local/libexec/crio/conmon
    - source: /usr/local/bin/conmon
    - makedirs: True

copy_pause:
  file.copy:
    - name: /usr/local/libexec/crio/pause
    - source: /usr/local/bin/pause
    - makedirs: True

copy_seccomp_file:
  file.copy:
    - name: /etc/crio/seccomp.json
    - source: /usr/local/bin/seccomp.json
    - makedirs: True

copy_crio_conf_file:
  file.copy:
    - name: /etc/crio/crio.conf
    - source: /usr/local/bin/crio.conf
    - makedirs: True

copy_policy_file:
  file.copy:
    - name: /etc/containers/policy.json
    - source: /usr/local/bin/policy.json
    - makedirs: True

/usr/local/bin/kube-proxy:
  file.managed:
    - source: https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kube-proxy
    - mode: 755
    - skip_verify: True
    - replace: False

/usr/local/bin/kubelet:
  file.managed:
    - source:  https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubelet
    - mode: 755
    - skip_verify: True
    - replace: False

/etc/cni/net.d/99-loopback.conf:
  file.managed:
    - source: salt://kubernetes/files/99-loopback.conf
    - makedirs: True

/etc/systemd/system/crio.service:
  file.managed:
    - source: salt://kubernetes/files/crio.service
    - makedirs: True

/var/lib/kubelet/{{ salt['grains.get']('id') }}.pem:
  file.copy:
    - source: /root/{{ salt['grains.get']('id') }}.pem
    - makedirs: True

/var/lib/kubelet/{{ salt['grains.get']('id') }}-key.pem:
  file.copy:
    - source: /root/{{ salt['grains.get']('id') }}-key.pem
    - makedirs: True

/var/lib/kubelet/kubeconfig:
  file.copy:
    - source: /root/{{ salt['grains.get']('id') }}.kubeconfig
    - makedirs: True

/var/lib/kubernetes/ca.pem:
  file.copy:
    - source: /root/ca.pem
    - makedirs: True

/etc/systemd/system/kubelet.service:
  file.managed:
    - source: salt://kubernetes/files/kubelet.service.j2
    - template: jinja
    - makedirs: True
    - defaults:
      hostname: {{ salt['grains.get']('id') }}
      
/var/lib/kube-proxy/kubeconfig:
  file.copy:
    - source: /root/kube-proxy.kubeconfig
    - makedirs: True

/etc/systemd/system/kube-proxy.service:
  file.managed:
    - source: salt://kubernetes/files/kube-proxy.service.j2
    - makedirs: True

systemctl_daemon_reload_for_workers:
  cmd.run:
    - name: systemctl daemon-reload

crio:
  service.running:
    - enable: True
    - reload: True

kubelet:
  service.running:
    - enable: True
    - reload: True

kube-proxy:
  service.running:
    - enable: True
    - reload: True
