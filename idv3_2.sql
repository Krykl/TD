select i.anio as año,i.provincia,i.parroquia,i.codigo,p.poblacion,round(i.idv3::numeric,4)as IDV3_parroq,round(v.promedio::numeric,4) as avg_provincia
from
(
SELECT 
  dim_tiempo.tie_anio anio, 
  fact_indicadores_td.fit_valor as idv3, 
  dim_ubicacion_geografica.ubi_parroquia as parroquia,
  dim_ubicacion_geografica.ubi_parroquia_cod as codigo, 
  dim_ubicacion_geografica.ubi_canton_cod as c_codigo, 
  dim_ubicacion_geografica.ubi_provincia as provincia, 
  dim_indicador_territorio_digitales.itd_sk as sk1
FROM 
  "TD".dim_indicador_territorio_digitales, 
  "TD".dim_ubicacion_geografica, 
  "TD".fact_indicadores_td, 
  public.dim_tiempo
WHERE 
  dim_indicador_territorio_digitales.itd_sk = fact_indicadores_td.fit_itd_sk AND
  dim_ubicacion_geografica.ubi_sk = fact_indicadores_td.fit_ubi_sk AND
  dim_indicador_territorio_digitales.itd_sk in(159) AND
  dim_tiempo.tie_sk = fact_indicadores_td.fit_tie_sk 
 )as i
join
(
SELECT 
  dim_tiempo.tie_anio anio, 
  fact_indicadores_td.fit_valor as poblacion, 
  dim_ubicacion_geografica.ubi_parroquia as parroquia,
  dim_ubicacion_geografica.ubi_parroquia_cod as codigo, 
  dim_ubicacion_geografica.ubi_canton_cod as c_codigo, 
  dim_ubicacion_geografica.ubi_provincia as provincia, 
  dim_indicador_territorio_digitales.itd_sk as sk1
FROM 
  "TD".dim_indicador_territorio_digitales, 
  "TD".dim_ubicacion_geografica, 
  "TD".fact_indicadores_td, 
  public.dim_tiempo
WHERE 
  dim_indicador_territorio_digitales.itd_sk = fact_indicadores_td.fit_itd_sk AND
  dim_ubicacion_geografica.ubi_sk = fact_indicadores_td.fit_ubi_sk AND
  dim_indicador_territorio_digitales.itd_sk in(160) AND
  dim_tiempo.tie_sk = fact_indicadores_td.fit_tie_sk 
 )as p
on(i.codigo = p.codigo)
join
(
SELECT 
dim_ubicacion_geografica.ubi_provincia as provincia,
avg(fact_indicadores_td.fit_valor) as promedio
FROM 
  "TD".dim_indicador_territorio_digitales, 
  "TD".dim_ubicacion_geografica, 
  "TD".fact_indicadores_td, 
  public.dim_tiempo
WHERE 
  dim_indicador_territorio_digitales.itd_sk = fact_indicadores_td.fit_itd_sk AND
  dim_ubicacion_geografica.ubi_sk = fact_indicadores_td.fit_ubi_sk AND
  dim_indicador_territorio_digitales.itd_sk in (159) AND
  dim_tiempo.tie_sk = fact_indicadores_td.fit_tie_sk 
  group by dim_ubicacion_geografica.ubi_provincia,dim_indicador_territorio_digitales.itd_sk
)as v
on(i.provincia = v.provincia)
order by i.provincia,i.idv3