# vyos-nfv

Generic tools to build NFV related artefacts based on VyOS 1.2x ISOs.

## stable-ova-converter

A tool to download and convert the OVA format into QCOW and ISO. It also download the rolling image as part of the process.

Once the tool is running, you should get some ISO file you can use to install manually VyOS on a baremetal or virtual environement.

## packet-vagrantboxes

A tool that take a vyos.iso file and convert it into a customized image for Virtualbox and Libvirt environments. This is using packer tool, and at the end of the process Vagrant boxes are generated automatically.

## docker-qemu

A simple docker to run a VyOS QCOW image in a control environment. This expect a vyos.img file to be present. This is a good environment to debug ansible script.

## docker-native

Highly risky but interesting experiment : running VyOS as a native container using the init sequence of the original ISO, with some twist in the Dockerfile.