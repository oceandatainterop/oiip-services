-- View: public.mview_vis_geom

-- DROP MATERIALIZED VIEW public.mview_vis_geom;

CREATE MATERIALIZED VIEW public.mview_vis_geom
TABLESPACE pg_default
AS
 SELECT catcheffort.rfmo,
    catcheffort.fishery,
    catcheffort.gridresolution,
    catcheffort.effort_units,
    catcheffort.catch_units,
    catcheffort.cpue_units,
    catcheffort.dates,
    catcheffort.lat,
    catcheffort.lon,
    catcheffort.effort,
    catcheffort.species,
    catcheffort.catch,
    catcheffort.cpue,
    st_makepoint(catcheffort.lon, catcheffort.lat) AS geom
   FROM catcheffort
WITH DATA;