certs:
  ca-config:
    signing:
      default:
        expiry: "8760h"
      profiles:
        kubernetes:
          usages:
            - "signing"
            - "key encipherment"
            - "server auth"
            - "client auth"
          expiry: 8760h
  ca-csr:
    CN: "Kubernetes"
    key:
      algo: "rsa"
      size: 2048
    names:
      - C: "US"
        L: "Portland"
        O: "Kubernetes"
        OU: "CA"
        ST: "Oregon"
  admin-csr:
    CN: "admin"
    key:
      algo: "rsa"
      size: 2048
    names:
      - C: "US"
        L: "Portland"
        O: "Kubernetes"
        OU: "My kubernetes"
        ST: "Oregon"
  worker-csr:
    CN: ""
    key:
      algo: "rsa"
      size: 2048
    names:
      - C: "US"
        L: "Portland"
        O: "Kubernetes"
        OU: "My kubernetes"
        ST: "Oregon"
  kubeproxy-csr:
    CN: "system:kube-proxy"
    key:
      algo: "rsa"
      size: 2048
    names:
      - C: "US"
        L: "Portland"
        O: "Kubernetes"
        OU: "My kubernetes"
        ST: "Oregon"
  kubernetes-csr:
    CN: "kubernetes"
    key:
      algo: "rsa"
      size: 2048
    names:
      - C: "US"
        L: "Portland"
        O: "Kubernetes"
        OU: "My kubernetes"
        ST: "Oregon"