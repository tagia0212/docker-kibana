FROM stackbrew/ubuntu:trusty
MAINTAINER Luis Arias <luis@balsamiq.com>

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install wget nginx-full apache2-utils

ADD config/etc /etc
WORKDIR /etc/nginx/sites-enabled
RUN rm * ; ln -s ../sites-available/kibana
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

WORKDIR /opt
RUN wget --no-check-certificate -O- https://download.elasticsearch.org/kibana/kibana/kibana-3.0.1.tar.gz | tar xvfz -
ADD config/config.js /opt/kibana-3.0.1/config.js
RUN mkdir /etc/kibana # This is where the htpasswd file is placed by the run script

ADD run /opt/run
RUN chmod +x /opt/run

ENV KIBANA_USER kibana
ENV KIBANA_PASSWORD kibana

EXPOSE 80

CMD /opt/run