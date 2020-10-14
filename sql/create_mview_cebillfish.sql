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
  WHERE catcheffort.species::text = ANY (ARRAY['BLM'::character varying::text, 'BUM'::character varying::text, 'MLS'::character varying::text, 'WHM'::character varying::text, 'SWO'::character varying::text, 'SSP'::character varying::text, 'SPF'::character varying::text, 'SFA'::character varying::text, 'SAI'::character varying::text])
  ORDER BY catcheffort.fishery, catcheffort.gridresolution, catcheffort.rfmo, catcheffort.effort_units, catcheffort.catch_units, catcheffort.cpue_units, catcheffort.dates, catcheffort.lat, catcheffort.lon, catcheffort.species;