SELECT 
  data.submission_id AS source_id, data.bin_class, data.depth, data.min_value AS measurement_value_min, data.max_value AS measurement_value_max, data.units AS measurement_units, data.type AS measurement_name, data.date_time AS measurement_date_time, data_position.date_time AS position_date_time, data_position.lat,
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
  data_profile.submission_id, data_profile.bin_class, data_profile.date_time, data_profile.depth, data_profile.min_value, data_profile.max_value, data_histogram_bin_unit.units, data_histogram_bin_unit.type, data_profile.position_date_time 
FROM data_profile, data_histogram_bin_unit 
WHERE
  (
    (data_profile.bin_id = data_histogram_bin_unit.bin_id) AND
    (data_histogram_bin_unit.tag_id = data_profile.tag_id)
  )) data, data_position 
WHERE
  (
    (data.submission_id = data_position.submission_id) AND
    (data.position_date_time = data_position.date_time)
  )