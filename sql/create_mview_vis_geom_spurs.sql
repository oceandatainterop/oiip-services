-- View: public.mview_vis_geom

-- DROP MATERIALIZED VIEW public.mview_vis_geom;

CREATE MATERIALIZED VIEW public.mview_vis_geom
TABLESPACE pg_default
AS
 SELECT DISTINCT ON (vis_data.source_id, vis_data.position_date_time) vis_data.source_id,
    vis_data.position_date_time,
    st_makepoint(vis_data.lon, vis_data.lat) AS geom
   FROM ( SELECT mview_vis_data.source_id,
            mview_vis_data.position_date_time,
            mview_vis_data.lon,
            mview_vis_data.lat
           FROM mview_vis_data) vis_data
  ORDER BY vis_data.source_id, vis_data.position_date_time
WITH DATA;

ALTER TABLE public.mview_vis_geom
    OWNER TO spurs;