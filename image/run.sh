kvm -m 1024 -snapshot -netdev user,id=mynet0,hostfwd=tcp::8022-:22 -netdev user,id=mynet1 -device pcnet,netdev=mynet0 -device pcnet,netdev=mynet1 ./output-ubuntu1604/ubuntu1604
