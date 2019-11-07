# Used for development only

FROM centos:7
RUN yum install -y wget unzip lsof && \
	yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel && \
	yum clean all
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0
ENV GEOSERVER_HOME /home/oiip/geoserver/
RUN mkdir /home/oiip
RUN mkdir -p /var/www

# Install and start GeoServer
WORKDIR /home/oiip/
RUN wget "https://downloads.sourceforge.net/project/geoserver/GeoServer/2.13.2/geoserver-2.13.2-bin.zip"
RUN wget "https://downloads.sourceforge.net/project/geoserver/GeoServer/2.13.2/extensions/geoserver-2.13.2-vectortiles-plugin.zip"
RUN unzip geoserver-2.13.2-bin.zip
RUN ln -s geoserver-2.13.2 geoserver
RUN unzip geoserver-2.13.2-vectortiles-plugin.zip
RUN mv *.jar geoserver/webapps/geoserver/WEB-INF/lib/

# Install and start Solr
WORKDIR /home/oiip/
RUN wget "http://archive.apache.org/dist/lucene/solr/6.4.2/solr-6.4.2.tgz"
RUN tar -xvzf solr-6.4.2.tgz
RUN ln -s solr-6.4.2 solr

# Start services
WORKDIR /home/oiip/
EXPOSE 8080 8983
CMD /home/oiip/solr/bin/solr start -m 8g -force && /home/oiip/geoserver/bin/startup.sh