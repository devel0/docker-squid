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
