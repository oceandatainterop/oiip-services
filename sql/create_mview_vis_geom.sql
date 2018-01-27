-- View: public.mview_vis_geom

-- DROP MATERIALIZED VIEW public.mview_vis_geom;

CREATE MATERIALIZED VIEW public.mview_vis_geom
TABLESPACE pg_default
AS
 SELECT DISTINCT ON (variable.submission_id, variable.tag_id, data_position.date_time) variable.submission_id,
    variable.tag_id,
    data_position.date_time AS position_date_time,
    st_makepoint(data_position.lon, data_position.lat) AS geom
   FROM ( SELECT x.variable_value,
            y.variable_name,
            x.date_time,
            x.submission_id,
            x.tag_id,
            y.variable_units,
            row_number() OVER () AS row_number
           FROM data_time_series x,
            observation_types y
          WHERE x.variable_id = y.variable_id AND x.variable_id <> 61 AND x.variable_id <> 58) variable,
    data_position
  WHERE variable.submission_id = data_position.submission_id AND variable.date_time >= data_position.date_time
  ORDER BY variable.submission_id, variable.tag_id, data_position.date_time, (variable.date_time - data_position.date_time)
WITH DATA;

ALTER TABLE public.mview_vis_geom
    OWNER TO tagbase;