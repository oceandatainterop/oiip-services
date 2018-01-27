-- View: public.mview_vis_geom

-- DROP MATERIALIZED VIEW public.mview_vis_geom;

CREATE MATERIALIZED VIEW public.mview_vis_geom
TABLESPACE pg_default
AS
 SELECT DISTINCT ON (vis_data.submission_id, vis_data.tag_id, vis_data.position_date_time) vis_data.submission_id,
    vis_data.tag_id,
    vis_data.position_date_time,
    st_makepoint(vis_data.lon, vis_data.lat) AS geom
   FROM ( SELECT mview_vis_data.submission_id,
            mview_vis_data.tag_id,
            mview_vis_data.position_date_time,
            mview_vis_data.lon,
            mview_vis_data.lat
           FROM mview_vis_data
        UNION
         SELECT mview_vis_data_histogram.submission_id,
            mview_vis_data_histogram.tag_id,
            mview_vis_data_histogram.position_date_time,
            mview_vis_data_histogram.lon,
            mview_vis_data_histogram.lat
           FROM mview_vis_data_histogram
        UNION
         SELECT mview_vis_data_profile.submission_id,
            mview_vis_data_profile.tag_id,
            mview_vis_data_profile.position_date_time,
            mview_vis_data_profile.lon,
            mview_vis_data_profile.lat
           FROM mview_vis_data_profile) vis_data
  ORDER BY vis_data.submission_id, vis_data.tag_id, vis_data.position_date_time
WITH DATA;

ALTER TABLE public.mview_vis_geom
    OWNER TO tagbase;