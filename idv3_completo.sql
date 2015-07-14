 SELECT i.anio AS a,
    i.provincia,
    i.parroquia,
    i.c_codigo,
    i.codigo,
    p.poblacion,
    round(c.celular::numeric, 4) AS celular,
    round(n.internet::numeric, 4) AS internet,
    round(m.computador::numeric, 4) AS computador,
    round(h.escolaridad::numeric, 4) AS escolaridad,
    round(z.no_pobreza::numeric, 4) AS no_pobreza,
    round(r.tasa_radiobases::numeric, 6) AS tasa_radiobases,
    round(i.idv3::numeric, 4) AS idv3,
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
            fact_indicadores_td.fit_valor AS celular,
            dim_ubicacion_geografica.ubi_parroquia AS parroquia,
            dim_ubicacion_geografica.ubi_parroquia_cod AS codigo
           FROM "TD".dim_indicador_territorio_digitales,
            "TD".dim_ubicacion_geografica,
            "TD".fact_indicadores_td,
            dim_tiempo
          WHERE dim_indicador_territorio_digitales.itd_sk = fact_indicadores_td.fit_itd_sk
           AND dim_ubicacion_geografica.ubi_sk = fact_indicadores_td.fit_ubi_sk 
           AND dim_indicador_territorio_digitales.itd_sk = 161 
          -- AND dim_ubicacion_geografica.ubi_parroquia_cod::numeric in (131653,070951)
           AND dim_tiempo.tie_sk = fact_indicadores_td.fit_tie_sk) c ON i.codigo = c.codigo
     JOIN ( SELECT dim_tiempo.tie_anio AS anio,
            fact_indicadores_td.fit_valor AS internet,
            dim_ubicacion_geografica.ubi_parroquia AS parroquia,
            dim_ubicacion_geografica.ubi_parroquia_cod AS codigo
           FROM "TD".dim_indicador_territorio_digitales,
            "TD".dim_ubicacion_geografica,
            "TD".fact_indicadores_td,
            dim_tiempo
          WHERE dim_indicador_territorio_digitales.itd_sk = fact_indicadores_td.fit_itd_sk 
          AND dim_ubicacion_geografica.ubi_sk = fact_indicadores_td.fit_ubi_sk 
          AND dim_indicador_territorio_digitales.itd_sk = 162 
          --AND dim_ubicacion_geografica.ubi_parroquia_cod::numeric in (131653,070951)
          AND dim_tiempo.tie_sk = fact_indicadores_td.fit_tie_sk) n ON i.codigo = n.codigo
     JOIN ( SELECT dim_tiempo.tie_anio AS anio,
            fact_indicadores_td.fit_valor AS computador,
            dim_ubicacion_geografica.ubi_parroquia AS parroquia,
            dim_ubicacion_geografica.ubi_parroquia_cod AS codigo
           FROM "TD".dim_indicador_territorio_digitales,
            "TD".dim_ubicacion_geografica,
            "TD".fact_indicadores_td,
            dim_tiempo
          WHERE dim_indicador_territorio_digitales.itd_sk = fact_indicadores_td.fit_itd_sk 
          AND dim_ubicacion_geografica.ubi_sk = fact_indicadores_td.fit_ubi_sk 
          AND dim_indicador_territorio_digitales.itd_sk = 163 
         -- AND dim_ubicacion_geografica.ubi_parroquia_cod::numeric in (131653,070951)
          AND dim_tiempo.tie_sk = fact_indicadores_td.fit_tie_sk) m ON i.codigo = m.codigo
     JOIN ( SELECT dim_tiempo.tie_anio AS anio,
            fact_indicadores_td.fit_valor AS escolaridad,
            dim_ubicacion_geografica.ubi_parroquia AS parroquia,
            dim_ubicacion_geografica.ubi_parroquia_cod AS codigo
           FROM "TD".dim_indicador_territorio_digitales,
            "TD".dim_ubicacion_geografica,
            "TD".fact_indicadores_td,
            dim_tiempo
          WHERE dim_indicador_territorio_digitales.itd_sk = fact_indicadores_td.fit_itd_sk 
          AND dim_ubicacion_geografica.ubi_sk = fact_indicadores_td.fit_ubi_sk 
          AND dim_indicador_territorio_digitales.itd_sk = 164 
         -- AND dim_ubicacion_geografica.ubi_parroquia_cod::numeric in (131653,070951)
          AND dim_tiempo.tie_sk = fact_indicadores_td.fit_tie_sk) h ON i.codigo = h.codigo
     JOIN ( SELECT dim_tiempo.tie_anio AS anio,
            fact_indicadores_td.fit_valor AS no_pobreza,
            dim_ubicacion_geografica.ubi_parroquia AS parroquia,
            dim_ubicacion_geografica.ubi_parroquia_cod AS codigo
           FROM "TD".dim_indicador_territorio_digitales,
            "TD".dim_ubicacion_geografica,
            "TD".fact_indicadores_td,
            dim_tiempo
          WHERE dim_indicador_territorio_digitales.itd_sk = fact_indicadores_td.fit_itd_sk 
          AND dim_ubicacion_geografica.ubi_sk = fact_indicadores_td.fit_ubi_sk 
          AND dim_indicador_territorio_digitales.itd_sk = 165 
         -- AND dim_ubicacion_geografica.ubi_parroquia_cod::numeric in (131653,070951)
          AND dim_tiempo.tie_sk = fact_indicadores_td.fit_tie_sk) z ON i.codigo = z.codigo

     JOIN ( SELECT dim_tiempo.tie_anio AS anio,
            fact_indicadores_td.fit_valor AS tasa_radiobases,
            dim_ubicacion_geografica.ubi_parroquia AS parroquia,
            dim_ubicacion_geografica.ubi_parroquia_cod AS codigo
           FROM "TD".dim_indicador_territorio_digitales,
            "TD".dim_ubicacion_geografica,
            "TD".fact_indicadores_td,
            dim_tiempo
          WHERE dim_indicador_territorio_digitales.itd_sk = fact_indicadores_td.fit_itd_sk 
          AND dim_ubicacion_geografica.ubi_sk = fact_indicadores_td.fit_ubi_sk 
          AND dim_indicador_territorio_digitales.itd_sk = 166 
         -- AND dim_ubicacion_geografica.ubi_parroquia_cod::numeric in (131653,070951)
          AND dim_tiempo.tie_sk = fact_indicadores_td.fit_tie_sk) r ON i.codigo = r.codigo

          
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
   
--where case when 3 = 1 then (i.codigo::numeric - i.c_codigo::numeric*100 > 50) 
--when 3 = 2 then (i.codigo::numeric - i.c_codigo::numeric*100 = 50)
--when 3 = 3 then (i.codigo::numeric - i.c_codigo::numeric*100 >= 50) end;