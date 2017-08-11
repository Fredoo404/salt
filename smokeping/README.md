# Smokeping salt state

For deploy smokeping to your minion :

 ```bash
 salt 'your_minion_id' state.sls smokeping
 ```

You can join your smokeping with default url : [http://smokeping/smokeping.cgi](http://smokeping/smokeping.cgi)

You can change this url with pillar defined in pillar/smokeping/init.sls.

| Distribution | Tested |
| ------------ | ------ |
| Debian 9     | Pass   |
| Ubuntu 17.04 | Not tested |
| Ubuntu 16.04 | Pass   |
| Fedora 25    | Not tested |
| Fedora 26    | Not tested |
| Centos 7     | Not tested |