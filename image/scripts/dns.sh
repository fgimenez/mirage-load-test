cat > /etc/dnsmasq.conf <<EOF
interface=br0
dhcp-range=192.168.56.150,192.168.56.200,1h
EOF
