# My salt-repo

This repo is my personal work with salt.

The salt state is only compatible with Centos 7.

## Zabbix server

Command to launch for deploy zabbix server :

 ```bash
 $ salt 'your_minion' state.sls zabbix
 ```

## Zabbix agent 

 ```bash
 $ salt 'your_minion' state.sls zabbix.agent
 ```

## Shinken

 ```bash
 $ salt 'your_minion' state.sls shinken
 ```
## Pillar

Of course you need to change the pillar for have a correct parameter install.

You can change this pillar in defaults.yaml file.