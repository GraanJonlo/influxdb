#!/bin/bash

chown influxdb:influxdb /data
chmod 0755 /data

exec /sbin/setuser influxdb /usr/bin/influxd -config /etc/service/influxdb/config.toml
