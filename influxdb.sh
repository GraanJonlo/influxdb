#!/bin/bash

chown influxdb:influxdb /data
chmod 0755 /data

exec /sbin/setuser influxdb /usr/bin/influxdb -config /opt/influxdb/shared/config.toml

