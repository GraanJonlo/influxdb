# What is InfluxDB?

InfluxDB is a time series, metrics, and analytics database. It’s written in Go and has no external dependencies. That means once you install it there’s nothing else to manage (like Redis, ZooKeeper, HBase, or whatever).

InfluxDB is targeted at use cases for DevOps, metrics, sensor data, and real-time analytics.

> [influxdb.com](http://influxdb.com/)

![logo](http://influxdb.com/images/influxdb-light400.png)

# How to use this image

## start an influxdb instance

    docker run -d --name influxdb [-p 8083:8083 -p 8086:8086 -p 8088:8088 -p 9091:8091] [-v /some/directory:/data] -d graanjonlo/influxdb[:tag]

This image includes `EXPOSE 8083, 8086, 8088 and 8091`, so standard container linking will make it automatically available to the linked containers. It also includes `VOLUME ["/data"]` so you can mount a data volume.

## connect to running instance

    docker exec -t -i influxdb /usr/bin/influx

