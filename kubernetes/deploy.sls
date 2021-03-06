#############################################################
#
# Mine update, refresh_pillar and set host file.
#
#############################################################
mine_update:
  salt.function:
    - name: mine.update
    - tgt: '*'

pillar_update:
  salt.function:
    - name: saltutil.refresh_pillar
    - tgt: '*'

resolv:
  salt.state:
    - tgt: '*'
    - sls: common.resolv

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
    - sls: kubernetes.etcd

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
    
    
#############################################################
#
# Bootstrapping load-balancer
#
#############################################################
bootstrapping_loadbalancer:
  salt.state:
    - tgt: 'roles:lb'
    - tgt_type: grain
    - sls: 
      - haproxy
      - kubernetes.lb
      - haproxy.service

#############################################################
#
# Bootstrapping workers
#
#############################################################
bootstrapping_workers_on_controllers:
  salt.state:
    - tgt: 'roles:controllers'
    - tgt_type: grain
    - sls:
      - kubernetes.workers
      - kubernetes.kubectl

#############################################################
#
# Bootstrapping workers
#
#############################################################
bootstrapping_workers:
  salt.state:
    - tgt: 'roles:workers'
    - tgt_type: grain
    - sls:
      - kubernetes.workers
      - kubernetes.kubectl

#############################################################
#
# Configure kubectl remote access and post install
#
#############################################################
kubectl_remote_access:
  salt.state:
    - tgt: 'roles:k8s-cli'
    - tgt_type: grain
    - sls:
      - kubernetes.remote_access
      - kubernetes.post_install