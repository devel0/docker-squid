# docker-dotnet

docker-ubuntu + squid proxy

## build image

```
./build.sh
```

you can specify addictional docker build arguments, example:

```
./build.sh --network=dkbuild
```

## run image

follow create a test named container running an interactive bash terminal

```
docker run --name=test -ti searchathing/squid
```

## config

difference from squid.conf.orig follows
- enabled access for private range addresses
- max object size 10GB
- max cache storage 50GB

```diff
971,975c971,975
< #acl localnet src 10.0.0.0/8	# RFC1918 possible internal network
< #acl localnet src 172.16.0.0/12	# RFC1918 possible internal network
< #acl localnet src 192.168.0.0/16	# RFC1918 possible internal network
< #acl localnet src fc00::/7       # RFC 4193 local private network range
< #acl localnet src fe80::/10      # RFC 4291 link-local (directly plugged) machines
---
> acl localnet src 10.0.0.0/8	# RFC1918 possible internal network
> acl localnet src 172.16.0.0/12	# RFC1918 possible internal network
> acl localnet src 192.168.0.0/16	# RFC1918 possible internal network
> acl localnet src fc00::/7       # RFC 4193 local private network range
> acl localnet src fe80::/10      # RFC 4291 link-local (directly plugged) machines
1186c1186
< #http_access allow localnet
---
> http_access allow localnet
3252c3252
< # maximum_object_size 4 MB
---
> maximum_object_size 10 GB
3410c3410
< #cache_dir ufs /var/spool/squid 100 16 256
---
> cache_dir ufs /var/spool/squid 51200 16 256
```

## test

- run squid image with a network/ip address
- run a test [ubuntu](https://github.com/devel0/docker-ubuntu) with proxy vars

```sh
docker run -ti \
  ftp_proxy=http://squidip:3128 \
  http_proxy=http://squidip:3128 \
  https_proxy=http://squidip:3128 \
  seachathing/ubuntu /bin/bash
```

- check squid log to see something like the follow

```
1520612642.374   3961 172.17.0.2 TCP_MISS/200 24117631 GET http://xxx/netboot/mini.iso - HIER_DIRECT/aaa.bbb.ccc.ddd application/octet-stream
1520612645.276    156 172.17.0.2 TCP_HIT/200 24117637 GET http://xxx/netboot/mini.iso - HIER_NONE/- application/octet-stream
```

trying downloading a 147MB image file ( first time TCP_MISS, second time TCP_HIT with immediate download from squid cache )
