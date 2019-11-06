CREATE MATERIALIZED VIEW public.mview_vis_data
(source_id, measurement_value, measurement_name, measurement_units, depth, measurement_date_time, position_date_time, lat, lon, lat_err, lon_err)
AS SELECT 
  variable.submission_id AS source_id, variable.variable_value AS measurement_value, variable.variable_name AS measurement_name, variable.variable_units AS measurement_units, depth.depth,
  variable.date_time AS measurement_date_time, data_position.date_time AS position_date_time, data_position.lat, 
  CASE 
    WHEN (data_position.lon > (180)::double precision) THEN (data_position.lon - (360)::double precision) 
    ELSE data_position.lon 
  END AS lon, 
  data_position.lat_err,  data_position.lon_err 
FROM ( SELECT 
  x.variable_value, 
  y.variable_name, 
  x.date_time, 
  x.submission_id, 
  y.variable_units, 
  x.position_date_time 
FROM data_time_series x, observation_types y 
WHERE
  (
    (x.variable_id = y.variable_id) AND
    (
      (y.variable_name)::text <> 'depth'::text
    ) AND
    (
      (y.variable_name)::text <> 'datetime'::text
    )
  )) variable, data_position, ( SELECT 
  x.variable_value AS depth, 
  x.date_time, 
  x.submission_id 
FROM data_time_series x, observation_types y 
WHERE
  (
    (x.variable_id = y.variable_id) AND
    (
      (y.variable_name)::text = 'depth'::text
    )
  )) depth 
WHERE
  (
    (variable.submission_id = data_position.submission_id) AND
    (variable.submission_id = depth.submission_id) AND
    (variable.position_date_time = data_position.date_time) AND
    (depth.date_time = variable.date_time)
  );
ALTER MATERIALIZED VIEW public.mview_vis_data
  OWNER TO tagbase;