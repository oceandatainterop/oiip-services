FROM centos:7

RUN yum install -y wget
RUN mkdir /home/oiip
RUN mkdir -p /var/www

# Install and start GeoServer
WORKDIR /home/oiip
RUN wget "https://downloads.sourceforge.net/project/geoserver/GeoServer/2.13.2/geoserver-2.13.2-bin.zip"
RUN wget "https://downloads.sourceforge.net/project/geoserver/GeoServer/2.13.2/extensions/geoserver-2.13.2-vectortiles-plugin.zip"
RUN unzip geoserver-2.13.2-bin.zip
RUN ln -s geoserver-2.13.2 geoserver
RUN unzip geoserver-2.13.2-vectortiles-plugin.zip
RUN mv *.jar geoserver/webapps/geoserver/WEB-INF/lib/

# Install and start Solr
WORKDIR /home/oiip
RUN wget "http://archive.apache.org/dist/lucene/solr/6.4.2/solr-6.4.2.tgz"
RUN tar -xvzf solr-6.4.2.tgz
RUN ln -s solr-6.4.2 solr

# Clone oiip-services repo and copy files
WORKDIR /home/oiip
RUN git clone https://git.earthdata.nasa.gov/scm/oiip/oiip-services.git
WORKDIR /home/oiip/oiip-services
RUN cp -R geoserver/data_dir/data/shapefiles /home/oiip/geoserver/data_dir/data/
RUN cp -R geoserver/data_dir/workspaces/oiip /home/oiip/geoserver/data_dir/workspaces/
RUN cp -R solr/oiip /home/oiip/solr/server/solr/

# Start services
WORKDIR /home/oiip/geoserver/bin
RUN nohup ./startup.sh &
WORKDIR /home/oiip/solr/bin
RUN nohup ./solr start -m 8g &