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

copy_ca_certs_on_controllers:
  salt.function:
    - name: cmd.run
    - tgt: 'roles:k8s-cli'
    - tgt_type: grain
    - arg:
      - 'salt-cp -G "roles:controllers" /root/ca-key.pem /root'
