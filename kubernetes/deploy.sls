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
# Deploy etcd on controllers
#
#############################################################
deploy_etcd:
  salt.state:
    - tgt: 'roles:controllers'
    - tgt_type: grain
    - sls: etcd

#############################################################
#
# Bootstrapping controllers
#
#############################################################
bootstrapping_controllers:
  salt.state:
    - tgt: 'roles:controllers'
    - tgt_type: grain
    - sls: kubernetes.controllers
    
    