# VyOS download tools

Tools to download VyOS (VMWare OVA and rolling release) and regenerate a 1.2 stable image.


## execution

The script is returning the URL as the first line, and the sha1 checksum in the second line

```
docker-compose build # build the dependency for the download script
docker-compose up # execute download script
#check ./download and ./output folders
docker-compose down # cleanup process
```
