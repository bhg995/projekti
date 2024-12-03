# Miniproject for Linux Config Management course

| Course name and code | Timing 
|----------|---------|
| Palvelinten hallinta ICI001AS3A-3010     | 2024 period 2, late autumn, w43-w50 | 

| Project | Author |
|---------|---------|
| Simple Wireguard test environment | Llanga

### Agenda

**The plan was to make very simple wireguard test environment with Linux**

<hr>
<br>
<hr>

Start by download the script
```bash
	$ git clone https://github.com/bhg995/projekti.git
```
After downloading, move to the folder and execute the script
```bash
	$ cd projekti/
	$ chmod +x bootstrap.sh 
	$ sudo ./bootstrap.sh 
```
Now it will download salt-master and salt-minion, after updating and upgrading the system. 

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
	$ sudo salt '*' state.apply
```
it should do 3 things

- generate wireguard keys for all, for master and 2 minions
- configure the wireguard configuration file `wg0` for all
- ensure that the wireguard service is running for all

Test connection

	$ ping 1.1.1.1 #master itself
 
 ![firstTest](https://github.com/bhg995/paha/blob/main/ias/1.1.1.1.png?raw=true)
 
 	$ ping 8.8.8.8 #google

![secondTest](https://github.com/bhg995/paha/blob/main/ias/8.8.8.8.png?raw=true)

  	$ ping 192.168.56.4 #from the minions to master

![lastTest](https://github.com/bhg995/paha/blob/main/ias/192.1.png?raw=true)

I've done it with one computer without any virtual machines running in the background. So the last ping doesn't really connect to master. If you want connection between all the machines Master and 2 minions, you want to make separate virtual machines and use their IP addresses. 

[Vagrant](https://developer.hashicorp.com/vagrant/install) is great for that.


<hr>

