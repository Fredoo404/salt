#############################################################
#
# Create All necessary certificate.
#
#############################################################
create_certs:
  salt.state:
    - tgt: 'role:k8s-cli'
    - tgt_type: grains
    - sls: kubernetes.certs

copy_ca_certs_on_controllers:
  salt.function:
    - name: cmd.run
    - tgt: 'role:k8s-cli'
    - tgt_type: grains
    - arg:
      - 'salt-cp -G "role:controllers" /root/ca-key /root'
