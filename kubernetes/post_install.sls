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
