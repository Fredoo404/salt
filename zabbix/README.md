# Zabbix server

Command to launch for deploy zabbix server :

 ```bash
 $ salt 'your_minion' state.sls zabbix
 ```
For finalize installation, you must contact your zabbix server from your browser like below :

```bash
http://your_ip/zabbix
```

Default login/password : admin / zabbix

## Zabbix agent 

 ```bash
 $ salt 'your_minion' state.sls zabbix.agent
 ```

## Compatible 

Work on Centos 7.
