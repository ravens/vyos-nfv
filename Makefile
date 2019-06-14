all: packer

clean:
	rm -Rf build_qemu build_virtualbox *.box

packer:
	python vyos-latest.py

docker: packer
	docker-compose build --no-cache
