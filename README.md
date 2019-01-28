# vyos-nfv
Tools to generate a cloud-ready VyOS image
# VyOS NFV tools

## Packer-based QCOW2 image generator

We use a standard Ubuntu LTE (18.04) for this. First some dependencies :

```
wget https://releases.hashicorp.com/packer/1.3.3/packer_1.3.3_linux_amd64.zip # we fetch a recent packer from their website 
unzip packer_1.3.3_linux_amd64.zip && sudo mv packer /usr/local/bin # make the binary available to the system users
adduser $USER kvm # required for packer to use KVM as normal user
```

And then we can generate a new image : 
```
packer build -var-file=vyos-var.json vyos.qcow2.json
```

Adjust variables in vyos-var.json if necessary.

