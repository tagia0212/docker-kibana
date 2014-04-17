FROM stackbrew/ubuntu:saucy
MAINTAINER Luis Arias <luis@balsamiq.com>

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install wget nginx-full apache2-utils

WORKDIR /opt
RUN wget --no-check-certificate -O- https://download.elasticsearch.org/kibana/kibana/kibana-3.0.1.tar.gz | tar xvfz -
RUN mkdir /etc/kibana

ADD config/etc /etc
WORKDIR /etc/nginx/sites-enabled
RUN rm * ; ln -s ../sites-available/kibana ; ln -s ../sites-available/ssl-redirect
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

WORKDIR /usr/local/bin
ADD run /usr/local/bin/run
RUN chmod +x run

ENV KIBANA_USER kibana
ENV KIBANA_PASSWORD kibana

EXPOSE 80 443