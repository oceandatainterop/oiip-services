CREATE MATERIALIZED VIEW public.mview_vis_metadata
TABLESPACE pg_default
AS
 SELECT metadata.submission_id AS source_id,
    'Global Attributes'::text AS attribute_type,
    NULL::character varying AS variable,
    metadata_types.category,
    metadata_types.attribute_name,
    "left"("right"(metadata.attribute_value, length(metadata.attribute_value) - 1), '-1'::integer) AS attribute_value
   FROM metadata_types,
    metadata
  WHERE metadata_types.attribute_id = metadata.attribute_id AND (metadata_types.category::text = 'instrument'::text AND (metadata_types.attribute_name::text = ANY (ARRAY['instrument_name'::character varying, 'instrument_type'::character varying, 'firmware'::character varying, 'manufacturer'::character varying, 'model'::character varying, 'owner_contact'::character varying, 'person_owner'::character varying, 'serial_number'::character varying]::text[])) OR metadata_types.category::text = 'programming'::text AND (metadata_types.attribute_name::text = ANY (ARRAY['programming_report'::character varying, 'programming_software'::character varying]::text[])) OR metadata_types.category::text = 'attachment'::text AND metadata_types.attribute_name::text = 'attachment_method'::text OR metadata_types.category::text = 'deployment'::text AND (metadata_types.attribute_name::text = ANY (ARRAY['geospatial_lat_start'::character varying, 'geospatial_lon_start'::character varying, 'person_tagger_capture'::character varying, 'time_coverage_start'::character varying]::text[])) OR metadata_types.category::text = 'animal'::text AND (metadata_types.attribute_name::text = ANY (ARRAY['condition_capture'::character varying, 'length_capture'::character varying, 'length_method_capture'::character varying, 'length_type_capture'::character varying, 'length_unit_capture'::character varying, 'platform'::character varying, 'taxonomic_serial_number'::character varying]::text[])) OR metadata_types.category::text = 'end_of_mission'::text AND (metadata_types.attribute_name::text = ANY (ARRAY['time_coverage_end'::character varying, 'end_details'::character varying, 'end_type'::character varying, 'geospatial_lat_end'::character varying, 'geospatial_lon_end'::character varying]::text[])) OR metadata_types.category::text = 'waypoints'::text AND metadata_types.attribute_name::text = 'waypoints_source'::text OR metadata_types.category::text = 'quality'::text AND (metadata_types.attribute_name::text = ANY (ARRAY['found_problem'::character varying, 'person_qc'::character varying]::text[])))
UNION
 SELECT data_time_series.submission_id AS source_id,
    'Variable Attributes'::text AS attribute_type,
    observation_types.standard_name AS variable,
    NULL::character varying AS category,
    'units'::character varying AS attribute_name,
    observation_types.variable_units AS attribute_value
   FROM observation_types,
    ( SELECT data_time_series_1.variable_id,
            data_time_series_1.submission_id
           FROM data_time_series data_time_series_1
          GROUP BY data_time_series_1.variable_id, data_time_series_1.submission_id) data_time_series
  WHERE observation_types.standard_name IS NOT NULL AND observation_types.variable_id = data_time_series.variable_id
UNION
 SELECT data_time_series.submission_id AS source_id,
    'Variable Attributes'::text AS attribute_type,
    observation_types.standard_name AS variable,
    NULL::character varying AS category,
    'standard_name'::character varying AS attribute_name,
    observation_types.standard_name AS attribute_value
   FROM observation_types,
    ( SELECT data_time_series_1.variable_id,
            data_time_series_1.submission_id
           FROM data_time_series data_time_series_1
          GROUP BY data_time_series_1.variable_id, data_time_series_1.submission_id) data_time_series
  WHERE observation_types.standard_name IS NOT NULL AND observation_types.variable_id = data_time_series.variable_id
UNION
 SELECT data_time_series.submission_id AS source_id,
    'Variable Attributes'::text AS attribute_type,
    observation_types.standard_name AS variable,
    NULL::character varying AS category,
    'long_name'::character varying AS attribute_name,
    observation_types.variable_name AS attribute_value
   FROM observation_types,
    ( SELECT data_time_series_1.variable_id,
            data_time_series_1.submission_id
           FROM data_time_series data_time_series_1
          GROUP BY data_time_series_1.variable_id, data_time_series_1.submission_id) data_time_series
  WHERE observation_types.standard_name IS NOT NULL AND observation_types.variable_id = data_time_series.variable_id
WITH DATA;

ALTER TABLE public.mview_vis_metadata
    OWNER TO tagbase;