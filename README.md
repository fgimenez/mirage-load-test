This repo hosts files related to the load test MirageOS project described in
http://canopy.mirage.io/Projects/load

# Dev box

The development machine is defined using a [packer](https://www.packer.io/) template
and some helper files, all under the `image` directory. For generating the image you need
a recent version of packer (tested with v0.11.0) and qemu with kvm support, on a ubuntu
16.04 host you need to execute:

    $ sudo apt-get install qemu-kvm libvirt-bin bridge-utils virt-manager

Then, from the `image` directory, you can execute:

    $ packer build ubuntu.json

After the automated process finishes the resulting image is stored in `image/output-mlt/mlt`.
You can start it from the project's root with:

    $ kvm -m 1024 -snapshot -netdev user,id=mynet0,hostfwd=tcp::8022-:22 -netdev user,id=mynet1 -device pcnet,netdev=mynet0 -device pcnet,netdev=mynet1 ./image/output-mlt/mlt

After a few seconds the instance will be accessible through ssh with this command:

    $ ssh -i ./image/keypair/private -p 8022 mlt@localhost

The complete process of image creation, instance spin up and remote execution of
commands on it is automated in the `run.sh` script at the root of the project.
