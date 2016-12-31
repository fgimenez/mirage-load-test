su -l -c "opam init -a" ubuntu
su -l -c "opam remote add mirage-dev git://github.com/mirage/mirage-dev" ubuntu
su -l -c "opam update" ubuntu
su -l -c "opam upgrade -y" ubuntu
su -l -c "opam install mirage -v" ubuntu
