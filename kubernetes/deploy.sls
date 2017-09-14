#############################################################
#
# Fix name of machine
#
#############################################################
machine_name:
  salt.state:
    - tgt: '*'
    - sls: common.hostname

#############################################################
#
# Create All necessary certificate.
#
#############################################################
create_certs:
  salt.state:
    - tgt: 'roles:k8s-cli'
    - tgt_type: grain
    - sls: kubernetes.certs

#############################################################
#
# Deploy kubectl config
#
#############################################################
install_kubectl:
  salt.state:
    - tgt: 'roles:k8s-cli'
    - tgt_type: grain
    - sls: kubernetes.kubectl_config

#############################################################
#
# Bootstrapping controllers
#
#############################################################
encryption_config:
  salt.state:
    - tgt: 'roles:controllers'
    - tgt_type: grain
    - sls: kubernetes.controllers
    