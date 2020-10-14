 SELECT catcheffort.rfmo,
    catcheffort.fishery,
    catcheffort.gridresolution,
    catcheffort.effort_units,
    catcheffort.catch_units,
    catcheffort.dates,
    catcheffort.lat,
    catcheffort.lon,
    catcheffort.effort,
    st_makepoint(catcheffort.lon, catcheffort.lat) AS geom,
    codes_species.taxon_group AS species,
    sum(catcheffort.catch) AS catch
   FROM catcheffort
     JOIN codes_species ON catcheffort.species::text = codes_species.fao_code::text
  GROUP BY catcheffort.rfmo, catcheffort.fishery, catcheffort.gridresolution, catcheffort.effort_units, catcheffort.catch_units, catcheffort.dates, catcheffort.lat, catcheffort.lon, catcheffort.effort, codes_species.taxon_group, catcheffort.catch
  ORDER BY catcheffort.rfmo, catcheffort.fishery, catcheffort.gridresolution, catcheffort.effort_units, catcheffort.catch_units, catcheffort.dates, catcheffort.lat, catcheffort.lon, codes_species.taxon_group;