su -l -c "opam init -a" mlt
su -l -c "opam update" mlt
su -l -c "opam upgrade -y" mlt
su -l -c "opam switch ${OCAML_VERSION}" mlt
su -l -c "eval `opam config env`" mlt
PACKAGES="
cmdliner
depext
io-page
lwt
mirage
mirage-block-unix
mirage-block-xen
mirage-types
vhd-format
xen-evtchn
xen-gnt
xenstore
xenstore_transport
"
su -l -c "opam install -y $PACKAGES" mlt
su -l -c "git clone https://github.com/mirage/xen-disk /home/mlt/xen-disk" mlt
