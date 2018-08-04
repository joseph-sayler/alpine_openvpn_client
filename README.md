# alpine_openvpn_client
### OpenVPN Client Container

#### Setup Notes

1. Create a folder (call it anything) and then cd to that folder
2. Download the Dockerfile and put in this directory
3. Create another folder to act as local volume for the container's /vpn directory, then cd into that folder
	1. Here, put the ca file, crl file, and all the config scripts that are needed to connect to the vpn
	2. **Mandatory**, create a file called openvpn.sh and put in whatever commands are needed to start openvpn for your VPN provider.<br>This part has been kept vague so that you can put whatever you want in this folder for openvpn to run. I use PIA so for example, I put in the following extras:
		1. A file called `.login` to hold the VPN login credentials; change ownership of this file to root:root and set permissions to 600
		2. PIA's openvpn config scripts, found [here](https://www.privateinternetaccess.com/helpdesk/kb/articles/what-s-the-difference-between-the-ovpn-files); then unzip them in this folder
		3. A script for renaming these client files and adding any extra lines/info to make them run
4. If you are building the image from this repo, use the following command structure:<br>`docker build --tag=<REPOSITORY>:<TAG> .`
5. After building, use the following command structure to run the container:<br>`docker run -itd --name=<NAME> --cap-add=NET_ADMIN --device=/dev/net/tun -v <DIRECTORY>:/vpn <REPOSITORY>:<TAG>`
6. To make best use of this container, connect other containers to it. This is done by connecting your other containers networking to the openvpn container via the `--network` switch:<br>`docker run -itd --name=<NAME> --network=container:<CONTAINER NAME> --device=/dev/net/tun <REPOSITORY>:<TAG> <command>`

**See examples below for more detail.**

#### Some changes to consider:
	
- [ ] Create a placeholder for openvpn.sh so that the file exists, but user has to put in their own code
- [ ] ~~Put the Dockerfile on GitHub, GitLab, or Bitbucket~~
- [ ] Look into setting up iptables rules in the container to prevent any leaks and put script to make these rules online with dockerfile


### EXAMPLE USAGE

##### _Build_

`sudo docker build --tag=jsayler:alpine_openvpn .`
>_(note, for me, sudo is required due to the `.login` files ownership settings)_

##### _Run_

`docker run -itd --name=ovpn_alpine --cap-add=NET_ADMIN --device=/dev/net/tun -v <DIRECTORY>:/vpn jsayler:alpine_openvpn`

##### _Connect_

`docker run -itd --name=test_container --network=container:ovpn_alpine --device=/dev/net/tun alpine:latest sh`
