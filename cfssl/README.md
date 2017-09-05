# Cfssl

Cfssl is a tool for create and manage a PKI.

(More information about Cfssl)[https://github.com/cloudflare/cfssl]

For deploy this tools, you need to execute cfssl salt state :

```bash
salt "your_minion" state.apply cfssl
```

Verify cfssl version :

```bash
$ cfssl version
Version: 1.2.0
Revision: dev
Runtime: go1.6
```


| Distribution | Tested |
| ------------ | ------ |
| Debian 9     | Not tested |
| Ubuntu 17.04 | Not tested |
| Fedora 26    | Not tested |
| Centos 7     | Not tested |
