# My salt-repo

This repo is my personal work with salt.

You can find salt master configuration in salt/files/master in this repository.

This salt master configuration allow you to use directly this repository from your salt-master.

## Pillar

Pillar are a salt feature which allow to have a dynamic parameter in your salt state.

## How I can use this repository ?

For use this repository you need to configure correctly your salt master.

There are many ways todo this configuration :

### Salt master installation and configuration via salt-ssh :
 
 The objective of this point is to install salt-master service on your remote machine (virtual machine or cloud instance ...) from salt-ssh (from your desktop).

 1. Install salt-ssh on a virtualenv or in your desktop directly. It's like you want, I prefer virtualenv install :
 ```bash
 $ virtualenv salt
 $ source salt/bin/activate
 (salt)$ pip install salt-ssh
 ```

 2. Create a roster file wich contain your remote machine description :
 ```bash
 $ cat /etc/salt/roster
 my-salt-master:
   host: ip_of_your_remote_machine
   user: user_of_your_remote_machine
   priv: your_pubkey_for_connect_to_your_remote_machine
   sudo: True
 ```

 3. Test :
 ```bash
 $ salt-ssh '*' test.ping
  my-salt-master:
      True
 ```

 4. Clone salt repo :
 ```bash
 $ git clone https://github.com/Fredoo404/salt.git
 $ cd salt
 ```

 5. Execute salt state on your remote machine :
 ```bash
 $ salt-ssh 'my-salt-master' state.sls salt.master 
 ```

 6. From your remote machine your can encounter problem below :
 ```bash
 $ salt-run fileserver.update
 [ERROR   ] The git command line utility is required when using the 'pygit2' gitfs_provider.
 [CRITICAL] No suitable gitfs provider module is installed.
 True
 ```
 For resolve this problem you need to install GitPython package and restart salt-master.

More informations about salt-ssh : 

https://docs.saltstack.com/en/latest/topics/ssh/

https://docs.saltstack.com/en/latest/topics/tutorials/gitfs.html

### Salt infrastructure via salt-cloud :

You can also use salt-cloud for create a salt-master and a set of minion.

Salt-cloud is design for cloud architecture.

Here I use a compatible AWS cloud provider.

If you have used salt-ssh, salt-cloud binary is already installed.

 ```bash
 $ cat /etc/salt/cloud.providers.d/ec2.conf
  fcu-eu-west-2:
    driver: ec2
    id: 'XXXXXXXXXXXXXXXXXXXX'
    key: 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
    private_key: link_to_your_private_ssh_key
    keyname: name_of_your_keypair
    endpoint: fcu.eu-west-2.outscale.com
    location: eu-west-2
    availability_zone: eu-west-2a
    del_root_vol_on_destroy: True
    del_all_vols_on_destroy: True 
 ```

 ```bash
 $ cat /etc/salt/cloud.profiles.d/basic.conf
   m4_instance_fcu:
     provider: fcu-eu-west-2
     image: ami-xxxxxxxx
     size: m4.large
     ssh_username: fedora
 ```
 ```bash
 $ cat test.map
   m4_instance_fcu:
     - salt-master-test:
         make_master: True
         master:
           user: root
           interface: 0.0.0.0
           auto_accept: True
           fileserver_backend:
             - git
           gitfs_remotes:
             - https://github.com/fredoo404/salt.git
           ext_pillar:
             - git: master:base https://github.com/fredoo404/salt.git root=pillar
 ```

With configuration file above, you can create a salt master.

Wish to you to append minion in test.map file.

 ```bash
 # Create your salt infrastructure
 $ salt-cloud --map=./test.map

 # Destroy your salt infrastructure
 $ salt-cloud --map=./test.map --destroy

 # Create instance from defined cloud profile
 $ salt-cloud -p m4_instance_fcu your_instance_name
 
 # Destroy instance from define cloud profile
 $ salt-cloud -p m4_instance_fcu your_instance_name --destroy
 ```



