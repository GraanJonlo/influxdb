FROM phusion/baseimage:0.9.16

MAINTAINER Andy Grant <andy.a.grant@gmail.com>

RUN \
  apt-get update && apt-get upgrade -y && apt-get install -y \
  wget

RUN \
  cd /tmp && \
  wget -O influxdb.deb https://s3.amazonaws.com/influxdb/influxdb_0.8.8_amd64.deb && \
  dpkg -i influxdb.deb && \
  rm -rf /tmp/* && \
  rm /etc/init.d/influxdb

VOLUME ["/data"]

RUN mkdir -p /etc/service/influxdb
ADD influxdb.sh /etc/service/influxdb/run
ADD config.toml /opt/influxdb/shared/config.toml

EXPOSE 8083
EXPOSE 8086
EXPOSE 8090
EXPOSE 8099

CMD ["/sbin/my_init", "--quiet"]
