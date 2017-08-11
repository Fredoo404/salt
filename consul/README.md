# Consul salt state

You can deploy your consul infrastructure in the cloud thank to consul.map file.

 ```bash
 salt-cloud -P --map=consul.maps -y
 ```

Of course, you need to defined your profile in /etc/salt/cloud.profiles.d and your providers informations in /etc/salt/cloud.providers.d.

Check salt-cloud documentation for more informations about profiles and providers configurations.

| Distribution | Tested |
| ------------ | ------ |
| Debian 9     | Not tested |
| Ubuntu 17.04 | Not tested |
| Fedora 25    | Not tested |
| Fedora 26    | Not tested |
| Centos 7     | Not tested |