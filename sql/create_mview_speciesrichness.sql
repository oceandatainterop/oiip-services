 SELECT catcheffort.fishery,
    catcheffort.gridresolution,
    catcheffort.rfmo,
    catcheffort.effort_units,
    catcheffort.dates,
    catcheffort.lat,
    catcheffort.lon,
    catcheffort.effort,
	st_makepoint(catcheffort.lon, catcheffort.lat) AS geom,
    count(catcheffort.catch) AS richness
   FROM catcheffort
  WHERE catcheffort.catch > 0::double precision
  GROUP BY catcheffort.fishery, catcheffort.gridresolution, catcheffort.rfmo, catcheffort.effort_units, catcheffort.dates, catcheffort.lat, catcheffort.lon, catcheffort.effort
  ORDER BY catcheffort.fishery, catcheffort.gridresolution, catcheffort.rfmo, catcheffort.effort_units, catcheffort.dates, catcheffort.lat, catcheffort.lon;