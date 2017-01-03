DEV_PACKAGES="
curl
nmon
slurm
unzip
"

ESSENTIAL_PACKAGES="
ntp
nfs-common
xen-hypervisor-4.4-amd64
bridge-utils
build-essential
git
dnsmasq
ocaml-compiler-libs
ocaml-interp
ocaml-base-nox
ocaml-base
ocaml
ocaml-nox
ocaml-native-compilers
camlp4
camlp4-extra
m4
opam
pkg-config
libxen-dev
"

# apt-get sometimes hangs on security.ubuntu.com with IPv6.
sysctl -w net.ipv6.conf.all.disable_ipv6=1

if [ "$UPDATE" = true ]; then
    apt-get update
fi

if [[ $INSTALL_DEV_PACKAGES  =~ true || $INSTALL_DEV_PACKAGES =~ 1 ||
        $INSTALL_DEV_PACKAGES =~ yes ]]; then
  apt-get -y install $DEV_PACKAGES
fi

apt-get -y install $ESSENTIAL_PACKAGES
