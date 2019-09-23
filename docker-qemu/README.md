# Docker image to run VyOS

This docker image runs a QEMU-based instance of VyOS. It expects a VyOS.img to be present at build time. 

```
docker-compose build
docker-compose up
```

Wait for the ssh port to be available before trying to connect (port 2222 is forwarded).

## Ansible based provisioning

Using the provided inventory, one can use Ansible network library to configure VyOS :
```
ansible-playbook -i inventory playbook.yml
```