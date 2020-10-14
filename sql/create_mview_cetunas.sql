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
  WHERE catcheffort.species::text = ANY (ARRAY['ALB'::character varying::text, 'BET'::character varying::text, 'BFT'::character varying::text, 'BKJ'::character varying::text, 'PBF'::character varying::text, 'SBF'::character varying::text, 'SKJ'::character varying::text, 'YFT'::character varying::text])
  ORDER BY catcheffort.fishery, catcheffort.gridresolution, catcheffort.rfmo, catcheffort.effort_units, catcheffort.catch_units, catcheffort.cpue_units, catcheffort.dates, catcheffort.lat, catcheffort.lon, catcheffort.species;