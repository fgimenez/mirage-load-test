DEV_PACKAGES="
curl
emacs24-nox
htop
nmon
slurm
tcpdump
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
"

if [[ $INSTALL_DEV_PACKAGES  =~ true || $INSTALL_DEV_PACKAGES =~ 1 ||
        $INSTALL_DEV_PACKAGES =~ yes ]]; then
  apt-get -y install $DEV_PACKAGES
fi

apt-get -y install $ESSENTIAL_PACKAGES
