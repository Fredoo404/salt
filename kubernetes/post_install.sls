/root/kube-apiserver-to-kubelet.yml:
  file.managed:
    - source: salt://kubernetes/files/kube-apiserver-to-kubelet.yml

kubectl_create_kube_apiserver_to_kubelet:
  cmd.run:
    - name: kubectl create -f /root/kube-apiserver-to-kubelet.yml --kubeconfig /root/.kube/config
    - cwd: /root

/root/kube-apiserver.yml:
  file.managed:
    - source: salt://kubernetes/files/kube-apiserver.yml

kubectl_create_kube_apiserver:
  cmd.run:
    - name: kubectl create -f /root/kube-apiserver.yml --kubeconfig /root/.kube/config
    - cwd: /root

# Todo : Uncomment when pod-cidr is in pillar with 10.244.0.0/16 subnet.
#kubectl_flannel:
#  cmd.run:
#    - name: kubectl create -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml --kubeconfig /root/.kube/config
#    - cwd: /root
#
#kubectl_dns:
#  cmd.run:
#    - name: kubectl create -f https://storage.googleapis.com/kubernetes-the-hard-way/kube-dns.yaml --kubeconfig /root/.kube/config
#    - cwd: /root
