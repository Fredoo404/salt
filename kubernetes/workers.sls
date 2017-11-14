
install_dependencies:
  pkg.installed:
    - pkgs:
      - socat 

/opt/cni/bin:
  file.directory:
    - makedirs: True

retrieve_and_extract_containerd:
  archive.extracted:
    - name: /
    - source: https://github.com/kubernetes-incubator/cri-containerd/releases/download/v1.0.0-alpha.0/cri-containerd-1.0.0-alpha.0.tar.gz
    - archive_format: tar
    - skip_verify: True
    - enforce_toplevel: False

retrieve_and_extract_cni:
  archive.extracted:
    - name: /opt/cni/bin/
    - source: https://github.com/containernetworking/plugins/releases/download/v0.6.0/cni-plugins-amd64-v0.6.0.tgz
    - archive_format: tar
    - skip_verify: True
    - enforce_toplevel: False

/usr/local/bin/kube-proxy:
  file.managed:
    - source: https://storage.googleapis.com/kubernetes-release/release/v{{ salt['pillar.get']('kubernetes:version') }}/bin/linux/amd64/kube-proxy
    - mode: 755
    - skip_verify: True
    - replace: False

/usr/local/bin/kubelet:
  file.managed:
    - source:  https://storage.googleapis.com/kubernetes-release/release/v{{ salt['pillar.get']('kubernetes:version') }}/bin/linux/amd64/kubelet
    - mode: 755
    - skip_verify: True
    - replace: False

/etc/cni/net.d/99-loopback.conf:
  file.managed:
    - source: salt://kubernetes/files/99-loopback.conf
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

{% if salt['grains.get']('roles') == 'controllers' %}
/etc/systemd/system/kubelet.service:
  file.managed:
    - source: salt://kubernetes/files/kubelet.service.controllers.j2
    - template: jinja
    - makedirs: True
    - defaults:
      hostname: {{ salt['grains.get']('id') }}
{% else %}
/etc/systemd/system/kubelet.service:
  file.managed:
    - source: salt://kubernetes/files/kubelet.service.j2
    - template: jinja
    - makedirs: True
    - defaults:
      hostname: {{ salt['grains.get']('id') }}
{% endif %}
      
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

containerd:
  service.running:
    - enable: True
    - reload: True

cri-containerd:
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
