sysctl -w net.ipv6.conf.all.disable_ipv6=0
sysctl -w net.ipv6.conf.default.disable_ipv6=0
sysctl -w net.ipv4.ip_forward=0
cd /dev && mkdir net && mknod net/tun c 10 200 && chmod 0666 net/tun
iptables -A FORWARD -i eth0 -o tun0 -j ACCEPT
iptables -A FORWARD -i tun0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
