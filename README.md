# Miniproject for Linux Config Management course

| Course name and code | Timing 
|----------|---------|
| Palvelinten hallinta ICI001AS3A-3010     | 2024 period 2, late autumn, w43-w50 | 

| Project | Author |
|---------|---------|
| Simple Wireguard test environment | Llanga

### Agenda

**Simple server Wireguard server configuration with salt**

**UPDATED: Very simple wireguard client installation and configuration** 5.12.2024

<hr>
<br>
<hr>

Make sure you have Master-minion architecture set up

[Manual installation](https://github.com/bhg995/paha/blob/main/h4.md), in finnish.

Start by download the script
```bash
	$ git clone https://github.com/bhg995/projekti.git
```
After downloading, move to the folder and copy the `/salt` folder and contents to `/srv` folder, and then run it
```bash
	$ cd projekti/
	$ sudo cp -r salt/ /srv/ 
	$ sudo salt '*' state.apply 
```

Now this should download wireguard and after that begin configuring the server. Salt will handle configuring, it'll fetch information from `wireguard.sls` and `wg0.conf.jinja`.

Now, you should have server config file in the minion looking like:
```.conf
[Interface]
PrivateKey=iF4LmcDRmXvUF0RybazIaY3/aQCWj3RYz/+tqagMWVY=
Address = 10.0.0.1/24
SaveConfig=true

PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o wlan0 -j MASQUERADE

ListenPort=51820
```

It has made public and private keys and inserted in the conf file. You might neet to change the `wlan0`, depending on the interface of your server.

```bash
ip -o -4 route show to default | awk '{print $5}'
```

If everything looks good, start the wireguard server service:
```bash
wg-quick up wg0
```
check that it is working 

```.sh
$ sudo wg show
$ ip link
```

check that server is routing all ipv4 traffic

```.sh
$ cat /proc/sys/net/ipv4/ip_forward

$ sudo sysctl -w net.ipv4.ip_forward=1 # run this command if the output of previous is 0
```


Go to the client computer and generate keys
```.sh
sudo wg genkey | sudo tee /etc/wireguard/privatekey | sudo wg pubkey | sudo tee /etc/wireguard/publickey
```


Now, create a `wg0.conf` file for the client too. It should look something like:

```.conf
[Interface]
Address = 10.0.0.2/8
SaveConfig = true
ListenPort = 60943
FwMark = 0xca6c
PrivateKey = gBbP7DMh00ONpinsgDJByD4rpzSkIw4B/ftdAVZ++Hw=

[Peer]
PublicKey = s0Odcr7BUjzZO5ivEi9yHlRSZg8dGBKZWIgN3KRppEg=
AllowedIPs = 0.0.0.0/0
Endpoint = <serverIP>:51820
PersistentKeepalive = 20
```
Address should be unique and not interfere with any other networks, `ListenPort` and `FwMark` will be created once you get up and running 

start it with
```
wg-quick up wg0
```
copy the publickey for server
```
sudo wg
``` 
Now, on the server run the command, to allow traffic from client
```bash
$ sudo wg set wg0 peer 4396+c2RFzYlkm2kDbwNxm8RmfQiC5DY/BiA7dHuOWs= allowed-ips 10.0.0.2/32
```


**TEST**

**on the client**

ping 8.8.8.8

then on the **server** capture the traffic

```
sudo tcpdump -envi wg0 host 8.8.8.8
```


<hr>

