cat > /etc/network/interfaces <<EOF
auto lo
iface lo inet loopback

auto ens3
iface ens3 inet dhcp

auto ens4
iface ens4 inet manual
    pre-up ifconfig $IFACE up
    post-down ifconfig $IFACE down

auto br0
iface br0 inet static
    bridge_ports ens4
    address 192.168.56.5
    broadcast 192.168.56.255
    netmask 255.255.255.0
    # disable ageing (turn bridge into switch)
    up /sbin/brctl setageing br0 0
    # disable stp
    up /sbin/brctl stp br0 off
EOF
