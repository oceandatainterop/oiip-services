 SELECT catcheffort.fishery,
    catcheffort.gridresolution,
    catcheffort.rfmo,
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
  WHERE catcheffort.species::text = ANY (ARRAY['BSG'::character varying::text, 'CCL'::character varying::text, 'FAL'::character varying::text, 'MAK'::character varying::text, 'OCS'::character varying::text, 'POR'::character varying::text, 'SMA'::character varying::text, 'SPL'::character varying::text, 'SPZ'::character varying::text, 'THR'::character varying::text])
  ORDER BY catcheffort.fishery, catcheffort.gridresolution, catcheffort.rfmo, catcheffort.effort_units, catcheffort.catch_units, catcheffort.cpue_units, catcheffort.dates, catcheffort.lat, catcheffort.lon, catcheffort.species;