#!/bin/bash

set -e

# Function to print messages
log() {
    local message="$1"
    echo "[INFO] $message"
}

error_exit() {
    local message="$1"
    echo "[ERROR] $message" >&2
    exit 1
}

log "Starting Docker configuration script."

# Create daemon.json file in /etc/docker
log "Creating /etc/docker/daemon.json..."
if ! mkdir -p /etc/docker; then
    error_exit "Failed to create /etc/docker directory."
fi

if ! cat <<EOF > /etc/docker/daemon.json
{
    "hosts": ["tcp://0.0.0.0:2375", "unix:///var/run/docker.sock"]
}
EOF
then
    error_exit "Failed to create /etc/docker/daemon.json."
fi

log "/etc/docker/daemon.json created successfully."

# Create the directory for docker.service.d if it doesn't exist
log "Creating /etc/systemd/system/docker.service.d directory..."
if ! mkdir -p /etc/systemd/system/docker.service.d; then
    error_exit "Failed to create /etc/systemd/system/docker.service.d directory."
fi

# Add override.conf file
log "Creating /etc/systemd/system/docker.service.d/override.conf..."
if ! cat <<EOF > /etc/systemd/system/docker.service.d/override.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd
EOF
then
    error_exit "Failed to create /etc/systemd/system/docker.service.d/override.conf."
fi

log "/etc/systemd/system/docker.service.d/override.conf created successfully."

# Reload the systemd daemon
log "Reloading systemd daemon..."
if ! systemctl daemon-reload; then
    error_exit "Failed to reload systemd daemon."
fi

log "Systemd daemon reloaded successfully."

# Restart docker service
log "Restarting Docker service..."
if ! systemctl restart docker.service; then
    error_exit "Failed to restart Docker service."
fi

log "Docker service restarted successfully."

log "Docker configuration script completed successfully."