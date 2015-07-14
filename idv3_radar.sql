 SELECT i.anio AS a,
    i.provincia,
    i.parroquia,
    i.c_codigo,
    i.codigo,
    a.indicador,
    round(a.valor::numeric, 5) AS valor,
    round(i.idv3::numeric, 5) AS idv3,
    p.poblacion,
    round(v.promedio::numeric, 4) AS avg_provincia
   FROM 

   ( SELECT dim_tiempo.tie_anio AS anio,
            fact_indicadores_td.fit_valor AS idv3,
            dim_ubicacion_geografica.ubi_parroquia AS parroquia,
            dim_ubicacion_geografica.ubi_parroquia_cod AS codigo,
            dim_ubicacion_geografica.ubi_canton_cod AS c_codigo,
            dim_ubicacion_geografica.ubi_provincia AS provincia,
            dim_indicador_territorio_digitales.itd_sk AS sk1
           FROM "TD".dim_indicador_territorio_digitales,
            "TD".dim_ubicacion_geografica,
            "TD".fact_indicadores_td,
            dim_tiempo
          WHERE dim_indicador_territorio_digitales.itd_sk = fact_indicadores_td.fit_itd_sk 
          AND dim_ubicacion_geografica.ubi_sk = fact_indicadores_td.fit_ubi_sk 
          AND dim_indicador_territorio_digitales.itd_sk = 159
          --AND dim_ubicacion_geografica.ubi_parroquia_cod::numeric in (131653,070951)
          AND dim_tiempo.tie_sk = fact_indicadores_td.fit_tie_sk) i

     JOIN ( SELECT dim_tiempo.tie_anio AS anio,
            fact_indicadores_td.fit_valor AS poblacion,
            dim_ubicacion_geografica.ubi_parroquia AS parroquia,
            dim_ubicacion_geografica.ubi_parroquia_cod AS codigo,
            dim_ubicacion_geografica.ubi_canton_cod AS c_codigo,
            dim_ubicacion_geografica.ubi_provincia AS provincia,
            dim_indicador_territorio_digitales.itd_sk AS sk1
           FROM "TD".dim_indicador_territorio_digitales,
            "TD".dim_ubicacion_geografica,
            "TD".fact_indicadores_td,
            dim_tiempo
          WHERE dim_indicador_territorio_digitales.itd_sk = fact_indicadores_td.fit_itd_sk
           AND dim_ubicacion_geografica.ubi_sk = fact_indicadores_td.fit_ubi_sk 
           AND dim_indicador_territorio_digitales.itd_sk = 160 
           --AND dim_ubicacion_geografica.ubi_parroquia_cod::numeric in (131653,070951)
           AND dim_tiempo.tie_sk = fact_indicadores_td.fit_tie_sk) p ON i.codigo = p.codigo

     JOIN ( SELECT dim_tiempo.tie_anio AS anio,
            fact_indicadores_td.fit_valor AS valor,
            dim_ubicacion_geografica.ubi_parroquia AS parroquia,
            dim_ubicacion_geografica.ubi_parroquia_cod AS codigo,
            dim_indicador_territorio_digitales.itd_indicador AS indicador
           FROM "TD".dim_indicador_territorio_digitales,
            "TD".dim_ubicacion_geografica,
            "TD".fact_indicadores_td,
            dim_tiempo
          WHERE dim_indicador_territorio_digitales.itd_sk = fact_indicadores_td.fit_itd_sk
           AND dim_ubicacion_geografica.ubi_sk = fact_indicadores_td.fit_ubi_sk 
           AND dim_indicador_territorio_digitales.itd_sk in (161,162,163,164,165,166) 
          -- AND dim_ubicacion_geografica.ubi_parroquia_cod::numeric in (131653,070951)
           AND dim_tiempo.tie_sk = fact_indicadores_td.fit_tie_sk) a ON i.codigo = a.codigo
               
     JOIN ( SELECT dim_ubicacion_geografica.ubi_provincia AS provincia,
            avg(fact_indicadores_td.fit_valor) AS promedio
           FROM "TD".dim_indicador_territorio_digitales,
            "TD".dim_ubicacion_geografica,
            "TD".fact_indicadores_td,
            dim_tiempo
          WHERE dim_indicador_territorio_digitales.itd_sk = fact_indicadores_td.fit_itd_sk 
          AND dim_ubicacion_geografica.ubi_sk = fact_indicadores_td.fit_ubi_sk 
          AND dim_indicador_territorio_digitales.itd_sk = 159 
         -- AND dim_ubicacion_geografica.ubi_parroquia_cod::numeric in(131653,070951)
          AND dim_tiempo.tie_sk = fact_indicadores_td.fit_tie_sk
	  GROUP BY dim_ubicacion_geografica.ubi_provincia, dim_indicador_territorio_digitales.itd_sk) v ON i.provincia = v.provincia
   where valor = 0 and (indicador not like '%radio%' and indicador not like '%Pobre%')
--where case when 3 = 1 then (i.codigo::numeric - i.c_codigo::numeric*100 > 50) 
--when 3 = 2 then (i.codigo::numeric - i.c_codigo::numeric*100 = 50)
--when 3 = 3 then (i.codigo::numeric - i.c_codigo::numeric*100 >= 50) end;