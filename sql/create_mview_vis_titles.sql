CREATE MATERIALIZED VIEW public.mview_vis_titles
( source_id, title, platform, project, mission, instrument, descriptions, meastime_min, meastime_max, lat_min, lat_max, lon_min, lon_max)
AS SELECT 
  vis_titles.source_id, vis_titles.title, vis_titles.platform, vis_titles.project, vis_titles.mission, vis_titles.instrument, vis_titles.descriptions, vis_titles.meastime_min, vis_titles.meastime_max, vis_titles.lat_min, vis_titles.lat_max, vis_titles.lon_min, vis_titles.lon_max 
FROM vis_titles;
ALTER MATERIALIZED VIEW public.mview_vis_titles
  OWNER TO tagbase;