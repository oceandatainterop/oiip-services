## Welcome to OIIP Services

OIIP Services provides the back-end infrastructure services for the Oceanographic In-situ Data Interoperability Project (OIIP).
It comprises of GeoServer and Solr.

* **/** contains documentation and a sample Dockerfile demonstrating a typical deployment of the services via GeoServer and Solr
* **geoserver/** contains shapefiles and styles used by OIIP
* **solr/oiip/** contains Solr configurations for OIIP using Tagbase in PostGIS
* **solr/oiiptest/** contains test Solr configurations for OIIP using Tagbase in Access
* **sql/** contains SQL commands for PostGIS to generate materialized views used by GeoServer to query point values

### Development Instructions

**Build Docker image**

docker build --no-cache -t oiip-services:latest .

**Run Docker image**

docker run -d --rm --name oiip-services -p 8080:8080 -p 8983:8983 oiip-services:latest
