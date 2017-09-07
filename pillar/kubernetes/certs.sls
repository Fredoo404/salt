certs:
  test: ok
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