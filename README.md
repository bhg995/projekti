# projekti

very simple wireguard test environment

Download the script
```bash
	$ git clone https://github.com/bhg995/projekti.git
```
After downloading, move to the folder and execute the script
```bash
	$ cd projekti/
	$ chmod +x bootstrap.sh 
	$ sudo ./bootstrap.sh 
```
Now it will download salt-master and salt-minion

If you get error `unable to locate salt-master` and `unable to locate salt-minion`, you probably need to install Salt from their [website](https://docs.saltproject.io/salt/install-guide/en/latest/)
```bash
	$ sudoedit /etc/salt/minion
```
and change `master: salt` to `master: localhost`, and restart the minion
```bash
	$ sudo systemctl restart salt-minion
```
then accept minions keys:
```bash
	$ sudo salt-key -L # to check
	$ sudo salt-key -A # to accept
```
then run the salt command
```bash
	$ $ sudo salt '*' state.apply
```
it should do 3 things

- generate wireguard keys for all 
- configure the wireguard configuration file `wg0` for all
- ensure that the wireguard service is running
