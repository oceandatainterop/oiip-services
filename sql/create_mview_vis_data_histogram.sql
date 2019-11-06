CREATE MATERIALIZED VIEW public.mview_vis_data_histogram
( source_id, bin_class, measurement_value, measurement_units, measurement_name, measurement_date_time, position_date_time, lat, lon, lat_err, lon_err)
AS
SELECT 
  data.submission_id AS source_id, data.min_value AS bin_class, data.frequency AS measurement_value, data.units AS measurement_units, data.type AS measurement_name, data.date_time AS measurement_date_time, data_position.date_time AS position_date_time, data_position.lat, 
  CASE 
    WHEN (
      data_position.lon > (180)::double precision
    ) THEN
      (
        data_position.lon - (360)::double precision
      ) 
    ELSE data_position.lon 
  END AS lon, 
  data_position.lat_err, 
  data_position.lon_err 
FROM ( SELECT 
  data_histogram_bin_info.min_value, data_histogram_bin_unit.units, data_histogram_bin_unit.type, data_histogram_bin_data.submission_id, data_histogram_bin_data.date_time, data_histogram_bin_data.frequency, data_histogram_bin_data.position_date_time 
FROM data_histogram_bin_info, data_histogram_bin_unit, data_histogram_bin_data 
WHERE
  (
    (data_histogram_bin_info.bin_id = data_histogram_bin_unit.bin_id) AND
    (data_histogram_bin_info.bin_id = data_histogram_bin_data.bin_id) AND
    (data_histogram_bin_info.bin_class = data_histogram_bin_data.bin_class) AND
    (data_histogram_bin_data.tag_id = data_histogram_bin_unit.tag_id)
  )) data, data_position 
WHERE
  (
    (data.submission_id = data_position.submission_id) AND
    (data.position_date_time = data_position.date_time)
  );
ALTER MATERIALIZED VIEW public.mview_vis_data_histogram
  OWNER TO tagbase;