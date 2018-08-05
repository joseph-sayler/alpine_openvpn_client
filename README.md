# OpenVPN Client Container

###### Get it now on [Docker Hub!](https://hub.docker.com/r/jsayler/alpine_openvpn_client/)

#### Setup Notes

1. Create a folder to act as a local volume for the container's `/vpn` directory, then `cd` into that folder
	1. Here, put any `ca`, `crl`, and config script files that are needed to connect to the vpn service. Then use the script in the next step to connect to a server.
	2. **Mandatory:** Create a file called `openvpn.sh` and supply the commands needed to connect to the service. An example would be `openvpn --config <CLIENT CONFIG FILE>`. This allows for maximum flexibility. Note that the service will not run as intended if this file is not included.
2. If you are building the image from this repo, use the following command structure:<br>`docker build --tag=<REPOSITORY>:<TAG> .`
3. After building, use the following command structure to run the container:<br>`docker run -itd --name=<NAME> --cap-add=NET_ADMIN --device=/dev/net/tun -v <DIRECTORY>:/vpn <REPOSITORY>:<TAG>`
4. To make best use of this container, connect other containers to it. This is done by connecting your other containers networking to the openvpn container via the `--network` switch:<br>`docker run -itd --name=<NAME> --network=container:<CONTAINER NAME> --device=/dev/net/tun <REPOSITORY>:<TAG> <command>`
