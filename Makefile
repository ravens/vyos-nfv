all: packer

stable:
	packer build -var-file=vyos-var.json -var iso_url=vyos-1.2.0-amd64.iso -var iso_checksum_type=none -parallel=false vyos.img.json

docker-stable:
	packer build -var-file=vyos-var.json -var iso_url=vyos-1.2.0-amd64.iso -var iso_checksum_type=none -parallel=false -only=qemu vyos.img.json 
	docker-compose build --no-cache
	
clean:
	rm -Rf build_qemu build_virtualbox *.box

packer:
	python vyos-latest.py

docker: packer
	docker-compose build --no-cache