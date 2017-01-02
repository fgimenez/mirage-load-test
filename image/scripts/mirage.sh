su -l -c "opam init -a" mlt
su -l -c "opam remote add mirage-dev git://github.com/mirage/mirage-dev" mlt
su -l -c "opam update" mlt
su -l -c "opam upgrade -y" mlt
su -l -c "opam install mirage -v" mlt
