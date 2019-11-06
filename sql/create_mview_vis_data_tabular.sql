CREATE MATERIALIZED VIEW public.mview_vis_data_tabular
(  source_id,  measurement_date_time,  position_date_time,  lat,  lon,  depth,  internal_temperature_d,  light_d,  temperature_d)
AS SELECT 
  source.source_id, source.measurement_date_time, source.position_date_time, source.lat, source.lon, source.depth, source."internal temperature" AS internal_temperature_d, source.light AS light_d, source.temperature AS temperature_d
FROM source 
ORDER BY 
  source.source_id, source.measurement_date_time, source.lat, source.lon, source.depth;

CREATE INDEX mview_vis_data_tabular_index01
  ON public.mview_vis_data_tabular
  ();

ALTER MATERIALIZED VIEW public.mview_vis_data_tabular
  OWNER TO tagbase;