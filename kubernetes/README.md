# How to deploy Kubernetes ?

First, you need to deploy infrastructure thank to maps file.

```bash
salt-cloud -P -m kubernetes.map -y
```

Next, connect to salt-master (k8s-kubectl) and launch deploy.sls orchestration state.

```bash
salt-run state.orchestrate kubernetes.deploy
```

When this orchestration state is executed, you can do a quick test :

```bash
##from k8s-kubectl
$ kubectl get node
NAME           STATUS    ROLES     AGE       VERSION
k8s-worker-0   Ready     <none>    19d       v1.8.0
k8s-worker-1   Ready     <none>    19d       v1.8.0
k8s-worker-2   Ready     <none>    19d       v1.8.0
```

# How to configure dns ?

Juste launch yml file below :

```bash
kubectl create -f https://storage.googleapis.com/kubernetes-the-hard-way/kube-dns.yaml
```

```bash
$ kubectl get pods -n kube-system
NAME                                         READY     STATUS    RESTARTS   AGE
kube-dns-7797cb8758-gdc48                    3/3       Running   6          4d
kube-dns-7797cb8758-wwqzl                    3/3       Running   9          4d
```

# How to configure network ?

I choose to install and configure flannel for network part.

For that, retrieve flannel yml file and adapt pod cidr parameter :

```bash
$ wget https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
$ sed -i 's/10.200.0.0\/16/Your_pod_cidr/g' kube-flannel.yml
$ kubectl create -f ./kube-flannel.yml
```

# Note

Worker don't work on Fedora because libapparmor.so.1 is needed. (No package found)

| Distribution | Tested   |
| ------------ | -------- |
| Debian 9     | Pass     |
| Ubuntu 16.04 | Pass     |
| Fedora 26    | Not pass |
| Centos 7     | Not Pass |