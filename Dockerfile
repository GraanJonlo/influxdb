FROM phusion/baseimage:0.9.19

MAINTAINER Andy Grant <andy.a.grant@gmail.com>

ADD https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

RUN apt-get install -y \
  wget

RUN rm -rf /var/lib/apt/lists/*

RUN \
  cd /tmp && \
  wget -O influxdb.deb https://dl.influxdata.com/influxdb/releases/influxdb_1.0.2_amd64.deb && \
  dpkg -i influxdb.deb && \
  rm -rf /tmp/* && \
  systemctl disable influxdb.service

VOLUME ["/data"]

RUN mkdir -p /etc/service/influxdb
ADD influxdb.sh /etc/service/influxdb/run
ADD config.toml /etc/service/influxdb/config.toml

EXPOSE 8083 8086

CMD ["/sbin/my_init", "--quiet"]
