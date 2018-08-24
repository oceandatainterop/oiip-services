# oiip-services
Backend visualization services for the Oceanographic In-situ Data Interoperability Project (OIIP)

docker/ contains a sample Dockerfile demonstrating a typical deployment of the services via GeoServer and Solr
geoserver/ contains shapefiles and styles used by OIIP
solr/oiip contains Solr configurations for OIIP using Tagbase in PostGIS
solr/oiiptest contains test Solr configurations for OIIP using Tagbase in Access
sql/ contains SQL commands for PostGIS to generate materialized views used by GeoServer to query point values