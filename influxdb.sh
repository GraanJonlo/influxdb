#!/bin/bash

chown influxdb:influxdb /data
chmod 0755 /data

exec /sbin/setuser influxdb /opt/influxdb/influxd -config /opt/influxdb/shared/config.toml

