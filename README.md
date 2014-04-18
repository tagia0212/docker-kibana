docker-kibana
=============

Kibana webapp.  This container is designed to run behind an elb with SSL offloading.  Port 80 redirects urls
to https if the X-Forwarded-Proto header is "https".

The following environment variables can be used to configure the container:

      KIBANA_USER         Basic auth username, default is kibana
      KIBANA_PASSWORD     Basic auth password, default is kibana

This container requires a link to an elasticsearch container using the "es" alias (see command line below).

This container can be built using:

      docker build -t balsamiq/docker-kibana .

For an elasticsearch container named "elasticsearch", this container can be run using:

      docker run -p 80:80 --link elasticsearch:es balsamiq/docker-kibana
