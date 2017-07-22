# Docker salt state

For deploy docker to your minion :

 ```bash
 salt 'your_minion_id' state.sls docker
 ```

| Distribution | Tested |
| ------------ | ------ |
| Debian 9     | Pass   |
| Ubuntu 17.04 | Pass   |
| Fedora 25    | Pass   |
| Fedora 26    | Not tested |
| Centos 7     | Not tested |