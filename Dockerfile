FROM phusion/baseimage:0.9.18

MAINTAINER Andy Grant <andy.a.grant@gmail.com>

ADD https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

RUN \
  apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold" && apt-get install -y \
  wget

RUN rm -rf /var/lib/apt/lists/*

RUN \
  cd /tmp && \
  wget -O influxdb.deb https://s3.amazonaws.com/influxdb/influxdb_0.12.0-1_amd64.deb && \
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

CMD ["/sbin/my_init", "--quiet"]
