# Miniproject for Linux Config Management course

| Course name and code | Timing 
|----------|---------|
| Palvelinten hallinta ICI001AS3A-3010     | 2024 period 2, late autumn, w43-w50 | 

| Project | Author |
|---------|---------|
| Simple Wireguard test environment | Llanga

### Agenda

**The plan was to make very simple wireguard ~~test environment~~ server with Linux**

**UPDATED: Very simple wireguard server** 5.12.2024

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
	$ chmod ugo+x bootstrap.sh 
	$ ./bootstrap.sh 
```

Now this should download wireguard and after that begin configuring the server. Salt will handle configuring, it'll fetch information from `wireguard.sls` and `wg0.conf.jinja`.

Test connection

	$ ping 1.1.1.1 #itself
 
 ![firstTest](https://github.com/bhg995/paha/blob/main/ias/1.1.1.1.png?raw=true)
 
 	$ ping 8.8.8.8 #google

![secondTest](https://github.com/bhg995/paha/blob/main/ias/8.8.8.8.png?raw=true)

You should have wireguard server ready to serve clients. You can edit those clients in under `[Peer]` in the `/etc/wireguard/wg0.conf` configuration file.

[Vagrant](https://developer.hashicorp.com/vagrant/install) is great for testing this.


<hr>

