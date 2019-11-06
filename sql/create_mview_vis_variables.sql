CREATE MATERIALIZED VIEW public.mview_vis_variables
(  source_id,  meastype1,  meastype2,  meastype3,  meastype4,  meastype5,  meastype6,  meastype7,  meastype8,  meastype9,  meastype10)
ASSELECT ct.source_id,    ct.meastype1,    ct.meastype2,    ct.meastype3,    ct.meastype4,    ct.meastype5,    ct.meastype6,    ct.meastype7,    ct.meastype8,    ct.meastype9,    ct.meastype10
FROM crosstab('
    SELECT source_id, measurement_name, cast(measurement_name || '' ('' ||        measurement_units || '')'' AS varchar(255))  AS measurement_nameunits
    FROM mview_vis_data
    GROUP BY source_id, measurement_name, measurement_units
    ORDER BY 1,2'::text
    ) ct(source_id bigint, meastype1 character varying(255), meastype2,  character varying(255), meastype3 character varying(255), meastype4  character varying(255), meastype5 character varying(255), meastype6  character varying(255), meastype7 character varying(255), meastype8  character varying(255), meastype9 character varying(255), meastype10  character varying(255));
ALTER MATERIALIZED VIEW public.mview_vis_variables
  OWNER TO tagbase;