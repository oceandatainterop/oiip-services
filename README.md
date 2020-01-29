## Welcome to OIIP Services

OIIP Services provides the back-end infrastructure services for the Oceanographic In-situ Data Interoperability Project (OIIP).
It comprises of GeoServer and Solr.

* [/](./) contains documentation and a sample Dockerfile demonstrating a typical deployment of the services via GeoServer and Solr
* [geoserver/](geoserver/) contains shapefiles and styles used by OIIP
* [solr/oiip/](solr/oiip/) contains Solr configurations for OIIP in PostGIS
* [solr/oiip_access/](solr/oiip_access/) contains test Solr configurations for OIIP using Tagbase in Access
* [sql/](sql/) contains SQL commands for PostGIS to generate materialized views used by GeoServer to query point values

### Development Instructions

**Build Docker image**

    docker build --no-cache -t oiip-services:latest .

**Run Docker image**

    docker run -d --rm --name oiip-services -p 8080:8080 -p 8983:8983 \
    -v $(pwd)/solr/oiip:/home/oiip/solr/server/solr/oiip \
    -v $(pwd)/geoserver/data_dir/data/shapefiles:/home/oiip/geoserver/data_dir/data/shapefiles \
    -v $(pwd)/geoserver/data_dir/workspaces/oiip:/home/oiip/geoserver/data_dir/workspaces/oiip \
    oiip-services:latest

**Note: The Docker image is intended as a reference for development and not for operational environments.**

Check out Solr at: [http://localhost:8983/solr/#/oiip](http://localhost:8983/solr/#/oiip)

Check out GeoServer at: [http://localhost:8080/geoserver/web/](http://localhost:8080/geoserver/web/)

The default username and password is **admin** and **geoserver**.

Files that are mounted to the container (e.g., [solr/oiip/](solr/oiip/)) can be modified as necessary.

Review the [Dockerfile](Dockerfile) to understand how software is configured.


### Architecture

OIIP Services relies on the following components:

* Solr - data service for charting and search
* GeoServer - data service for mapping
* PostGIS - data storage

![OIIP Architecture](images/oiip_architecture.png)

### Solr

OIIP data is indexed into Solr for high perfomance data queries. It is used by the OIIP Data Viewer primarily for charting and search.

[solr/oiip_access/](solr/oiip_access/) contains test Solr configurations for OIIP using Tagbase in Access. This may be useful for anyone who wants to connect Solr directly to [Tagbase](https://github.com/tagbase).

[solr/oiip/](solr/oiip/) contains Solr configurations for OIIP using PostGIS. This section of the documentation will refer to these configurations.

**Schema**

The [managed_schema](solr/oiip/conf/managed_schema) in [solr/oiip/conf](solr/oiip/conf) defines the field names that are used by Solr. Dynamic fields are used to index variable names. The last character after "\_" denotes the data type of dynamic fields (e.g. "*_d" type="double").

**Data Configuration**

The [solr-data-config.xml](solr/oiip/conf/solr-data-config.xml) file in [solr/oiip/conf](solr/oiip/conf) contains the data configuration and connection information to PostGIS tables. It is currently configured to three databases: **tagbase**, **taghost**, **spurs**, and **saildrone**. The passwords are omitted for security reasons.

Each **entity** generally maps to a database query to one table, but *mview_vis_titles* contains a join. These are the two common entities that are used:

* mview\_vis\_data\_tabular: Contains the data from *mview_vis_data_tabular* in tabular form

```
SELECT 'tagbase_data_'||row_number() OVER () as id, 'tagbase' as project, 'data' as datatype, * FROM public.mview_vis_data_tabular;
```

* mview\_vis\_titles: Contains the summary information of individual datasets from *mview_vis_titles* joined with its list of variables found in *mview_vis_variables*

```
SELECT 'tagbase_track_'||row_number() OVER () as id, concat_ws('|','tagbase',mview_vis_titles.source_id,trim(platform)) as track_id, 'track' as datatype, trim(platform) as platform, 'tagbase' as project, trim(project) as instrument, trim(instrument) as mission, extract(epoch from meastime_min) as start_date, extract(epoch from meastime_max) as end_date, lat_min, lat_max, lon_min, lon_max, descriptions as description, concat_ws('|',split_part(meastype1, ' (', 1),split_part(meastype2, ' (', 1),split_part(meastype3, ' (', 1),split_part(meastype4, ' (', 1),split_part(meastype5, ' (', 1),split_part(meastype6, ' (', 1),split_part(meastype7, ' (', 1),split_part(meastype8, ' (', 1),split_part(meastype9, ' (', 1),split_part(meastype10, ' (', 1)) as variables, concat_ws('|',substring(meastype1 from '\((.+)\)'),substring(meastype2 from '\((.+)\)'),substring(meastype3 from '\((.+)\)'),substring(meastype4 from '\((.+)\)'),substring(meastype5 from '\((.+)\)'),substring(meastype6 from '\((.+)\)'),substring(meastype7 from '\((.+)\)'),substring(meastype8 from '\((.+)\)'),substring(meastype9 from '\((.+)\)'),substring(meastype10 from '\((.+)\)')) as variables_units, mview_vis_titles.source_id FROM mview_vis_titles, mview_vis_variables WHERE mview_vis_titles.source_id = mview_vis_variables.source_id;
```

The following entities are not required but can be used if needed:
* mview\_vis\_data: Contains the data from mview\_vis\_data with data measurements group into arrays
* mview\_vis\_data_histogram: Contains the data from mview\_vis\_data\_histogram
* mview\_vis\_data_profile: Contains the data from mview\_vis\_data\_profile
* mview\_vis\_metadata: Contains the metadata about variables and attributes from mview\_vis\_metadata

**Data Import**

Importing data into the Solr index can be done manually via the [Dataimport interface](http://localhost:8983/solr/#/oiip/dataimport//dataimport). Ensure that the Data Configuration is correct and include relevant connection information and passwords. Hit **Execute** to begin the data import.

**Alternative**

Rather than using Solr, a light database service that queries the appropriate materialized views could be used. Solr may have better search performance and security abstraction, but comes at a cost of more complicated infrastructure and additional data replication.


### GeoServer

GeoServer provides GIS data services for OIIP. It is the primary map server for the OIIP Data Viewer.

All OIIP associated data uses the **oiip** workspace.

The passwords are omitted in the data [Stores](http://localhost:8080/geoserver/web/wicket/bookmarkable/org.geoserver.web.data.store.StorePage?5) for security reasons. Update as necessary for the **tagbase**, **taghost**, **spurs**, and **saildrone** stores.

Several layers and their Shapefiles are used by OIIP Services.

* err\_poly\_tagbase_4: Sample track error polygons
* err\_tagbase_4: Sample track error points
* FAO_AREAS: From [www.fao.org](http://www.fao.org:80/figis/geoserver/area/ows?service=WFS&request=GetFeature&version=1.0.0&typeName=area:FAO_AREAS&outputFormat=SHAPE-ZIP)
* ne\_10m\_ocean: From [www.naturalearthdata.com/downloads/10m-physical-vectors/10m-ocean/](https://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-ocean/)
* saildrone: PostGIS mview\_vis\_geom materialized view
* spurs: PostGIS mview\_vis\_geom materialized view
* tagbase: PostGIS mview\_vis\_geom materialized view
* taghost: PostGIS mview\_vis\_geom materialized view
* world\_borders: From [http://thematicmapping.org/downloads/TM_WORLD_BORDERS-0.3.zip](http://thematicmapping.org/downloads/TM_WORLD_BORDERS-0.3.zip)

From [http://www.marineregions.org/downloads.php](http://www.marineregions.org/downloads.php) (please download Shapefiles from there):
* World\_EEZ\_v8\_2014
* World\_Seas\_IHO\_v2

The **saildrone**, **spurs**, **taghost**, and **tagbase** layers use a connection to the **mview_vis_geom** materialized view, which contains the spatiotemporal information for tracks. Other track metadata is excluded as that information can be queried from Solr with better performance.

### PostGIS

OIIP data is stored in a PostGIS database. This repository does not contain configurations or data for PostGIS. Other databases supporting spatial data types should work as well.

Included in this repository under [sql/](sql/) are the SQL CREATE scripts for generating the materialized views that are used by Solr and GeoServer.

* **mview_vis_geom**
* **mview_vis_titles**
* **mview_vis_variables**
* **mview_vis_data_tabular**
* mview\_vis\_data
* mview\_vis\_data_histogram
* mview\_vis\_data_profile
* mview\_vis\_metadata

The **bold** views are the only ones required by either Solr or GeoServer.

Note that each "project" should have its own database and set of views.

### Reference Client

Check out [OIIP Data Viewer](https://github.com/oiip/oiip-data-viewer) for information about the client.

![OIIP Data Viewer](images/oiip_data_viewer.png)

