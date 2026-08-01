#!/bin/sh
set -e

# Initializes persistent storage links for the application.
#
# Creates the /config directory and ensures that required application data
# stored under /data is redirected to persistent storage.
#
# Missing files and directories are linked from /data to /config while
# existing entries are preserved.
#
# The Let's Encrypt directory is always recreated because Nginx Proxy Manager
# accesses certificates directly through /etc/letsencrypt.
#
# The script fails immediately when any command returns a non-zero exit code.
# This behavior is enabled by "set -e".

mkdir -p /config

# Redirect missing application data from /data to persistent storage.
#
# If an item does not exist in /data (neither as a file, directory, nor
# symbolic link), create a symbolic link pointing to the corresponding
# location under /config.
for item in nginx custom_ssl logs access letsencrypt-acme-challenge letsencrypt database.sqlite keys.json; do
    target="/data/$item"

    if [ ! -e "$target" ] && [ ! -L "$target" ]; then
        ln -s "/config/$item" "$target"
    fi
done

# Nginx Proxy Manager accesses Let's Encrypt certificates directly through
# /etc/letsencrypt. Always recreate this symbolic link to ensure it points
# to the persistent storage location.
rm -rf /etc/letsencrypt
ln -s /data/letsencrypt /etc/letsencrypt