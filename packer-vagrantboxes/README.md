# VyOS vagrant boxes builder

## prerequisites

Drop a vyos.iso in the folder before initiating packer.

## command line

```
packer build -var-file=vyos-var.json  -parallel=false vyos.json
```