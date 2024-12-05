
install_wireguard:
  pkg.installed:
    - name: wireguard

generate_keys:
  cmd.run:
    - name: |
        umask 022
        mkdir -p /etc/wireguard
        [ ! -f /etc/wireguard/privatekey ] && wg genkey | tee /etc/wireguard/privatekey | wg pubkey > /etc/wireguard/publickey
    - unless: test -f /etc/wireguard/privatekey

configure_wireguard:
  file.managed:
    - name: /etc/wireguard/wg0.conf
    - source: salt://wg0.conf.jinja
    - mode: 600
    - template: jinja

start_wireguard:
  service.running:
    - name: wg-quick@wg0
    - enable: True
