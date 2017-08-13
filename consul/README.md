# Consul salt state

You can deploy your consul infrastructure in the cloud thank to consul.map file.

 ```bash
 salt-cloud -P --map=consul.maps -y
 ```

Of course, you need to defined your profile in /etc/salt/cloud.profiles.d and your providers informations in /etc/salt/cloud.providers.d.

Check salt-cloud documentation for more informations about profiles and providers configurations.

For install consul server :

```bash
[root@consul-srv01 ~]# salt -C "G@roles:server" state.apply consul
```

If you want tuned consul configuration, you must edit consul pillar in pillar/consul/init.sls.

If you desire to add a new service for your consul agent, you need to create a new pillar in pillar/consul/services/your_service.sls and do a matching in pillar/top.sls.

Example :

```bash
# cat pillar/consul/services/your_service.sls
consul:
  config:
    services:
      - name: your_service

# cat pillar/top.sls
  '*consul*':
    - consul

  '*consul-agent*':
    - consul.services.test1
    - consul.services.your_service
```

| Distribution | Tested |
| ------------ | ------ |
| Debian 9     | Not tested |
| Ubuntu 17.04 | Not tested |
| Fedora 26    | Pass   |
| Centos 7     | Pass   |