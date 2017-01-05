PACKAGES="
bridge-utils
build-essential
camlp4
camlp4-extra
dnsmasq
git
libxen-dev
m4
nfs-common
ntp
ocaml
ocaml-base
ocaml-base-nox
ocaml-compiler-libs
ocaml-interp
ocaml-native-compilers
ocaml-nox
opam
pkg-config
uuid-dev
xen-hypervisor-4.4-amd64
"

# apt-get sometimes hangs on security.ubuntu.com with IPv6.
sysctl -w net.ipv6.conf.all.disable_ipv6=1

if [ "$UPDATE" = true ]; then
    apt-get update
fi

apt-get -y --no-install-recommends install $PACKAGES
