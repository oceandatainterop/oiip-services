 SELECT mview_dataset_metadata.iddataset,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Categories'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS categories_ss,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Data Access Endpoints_resourceURL1_viewer'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS data_access_endpoints_resourceurl1_viewer_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Data Access Endpoints_resourceURL2_sdap'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS data_access_endpoints_resourceurl2_sdap_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Data Access Endpoints_resourceURL3_tds'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS data_access_endpoints_resourceurl3_tds_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Data Access Endpoints_resourceURL4_nccs'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS data_access_endpoints_resourceurl4_nccs_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Data Access Endpoints_resourceURL5_opendap'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS data_access_endpoints_resourceurl5_opendap_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Data Access Endpoints_resourceURL6_wms'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS data_access_endpoints_resourceurl6_wms_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Data Access Endpoints_resourceURL7_wmts'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS data_access_endpoints_resourceurl7_wmts_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Data Access Endpoints_resourceURL8_iso'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS data_access_endpoints_resourceurl8_iso_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Data Access Endpoints_resourceURL9_iss'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS data_access_endpoints_resourceurl9_iss_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Description'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS description_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Documentation'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS documentation_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'DOI'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS doi_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'File Format'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS file_format_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Keywords'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS keywords_ss,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Latency'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS latency_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Metadata Source'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS metadata_source_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'MetdataSource_URL'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS metdatasource_url_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Observation Type'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS observation_type_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Parameter'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS parameter_ss,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Platform'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS platform_ss,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Processing Level'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS processing_level_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Project'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS project_ss,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Provider'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS provider_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Sensor'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS sensor_ss,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Shortname'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS shortname_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Spatial Extent'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS spatial_extent_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Spatial Resolution'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS spatial_resolution_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Spatial Type'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS spatial_type_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Temporal Extent'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS temporal_extent_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Temporal Resolution'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS temporal_resolution_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Thumbnail_URL'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS thumbnail_url_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Title'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS title_s,
    max(
        CASE
            WHEN mview_dataset_metadata.fieldname::text = 'Version'::text THEN mview_dataset_metadata.fieldvalue
            ELSE NULL::character varying
        END::text) AS version_s
   FROM mview_dataset_metadata
  GROUP BY mview_dataset_metadata.iddataset
  ORDER BY mview_dataset_metadata.iddataset;