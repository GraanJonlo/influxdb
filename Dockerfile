FROM phusion/baseimage:0.9.18

MAINTAINER Andy Grant <andy.a.grant@gmail.com>

RUN \
  apt-get update && apt-get upgrade -y && apt-get install -y \
  wget

RUN \
  cd /tmp && \
  wget -O influxdb.deb https://s3.amazonaws.com/influxdb/influxdb_0.11.0-1_amd64.deb && \
  dpkg -i influxdb.deb && \
  rm -rf /tmp/* && \
  rm /etc/init.d/influxdb

VOLUME ["/data"]

RUN mkdir -p /etc/service/influxdb
ADD influxdb.sh /etc/service/influxdb/run
ADD config.toml /etc/service/influxdb/config.toml

EXPOSE 8083
EXPOSE 8086
EXPOSE 8088
EXPOSE 8091

CMD ["/sbin/my_init", "--quiet"]
