generate_keys:
  cmd.run:
    - name: |
        umask 077
        mkdir -p /etc/wireguard
        wg genkey | tee /etc/wireguard/privatekey | wg pubkey > /etc/wireguard/publickey
    - unless: test -f /etc/wireguard/privatekey

configure_wireguard:
  file.managed:
    - name: /etc/wireguard/wg0.conf
    - source: salt://minion1/wg0.conf.jinja
    - user: root
    - group: root
    - mode: 600
    - template: jinja

enable_wireguard:
  service.running:
    - name: wg-quick@wg0
    - enable: True
