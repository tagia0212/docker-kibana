docker-kibana
=============

Kibana webapp.  This container is designed to run behind an elb with SSL offloading.  Port 80 redirects urls
to https.  Port 443 actually does not use SSL but is expecting the elb to forward https traffic to port 443 using http.  This setup will change so that the container only uses port 80 since it should be using the X-Forwarded-Proto header to decide whether to redirect to https or not.

The following environment variables can be used to configure the container:

      KIBANA_USER         Basic auth username, default is kibana
      KIBANA_PASSWORD     Basic auth password, default is kibana

This container requires a link to an elasticsearch container using the "es" alias (see command line below).

This container can be built using:

      docker build -t balsamiq/docker-kibana .

For an elasticsearch container named "elasticsearch", this container can be run using:

      docker run -p 80:80 -p 443:443 -link elasticsearch:es balsamiq/docker-logstash-ec2