# Docker Configuration Script

This bash script configures Docker to listen on both a TCP port and a Unix socket. It creates necessary configuration files and restarts the Docker service to apply the changes.

## Features

- Creates `/etc/docker/daemon.json` with specified hosts.
- Creates and populates `/etc/systemd/system/docker.service.d/override.conf` to override Docker service startup options.
- Reloads the systemd daemon.
- Restarts the Docker service.

## Prerequisites

- Mmust have Docker installed on your system.
- Need root or sudo privileges to execute the script.

## Easy Install w/ wget

To download and execute the script in one step, use the following command:

```sh
wget -O docker_socket_expose.sh "https://raw.githubusercontent.com/rtuszik/docker-socket-expose/main/docker_socket_expose.sh" && sh docker_socket_expose.sh
```
