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
  ca-csr:
    CN: "Kubernetes"
    key:
      algo: "rsa"
      size: "2048"
    names:
      - C: "US"
        L: "Portland"
        O: "Kubernetes"
        OU: "CA"
        ST: "Oregon"