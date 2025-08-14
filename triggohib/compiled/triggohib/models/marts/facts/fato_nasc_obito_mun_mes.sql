

WITH births AS (
  SELECT
    DATE_TRUNC('month', data_nascimento)     AS mes,
    codigo_municipio_residencia              AS codigo_municipio,
    COUNT(*)                                 AS nascidos_vivos
  FROM triggo_db.landing.int_nascimento
  GROUP BY 1,2
),
infant_deaths AS (
  SELECT
    DATE_TRUNC('month', data_obito)          AS mes,
    codigo_mun_residencial                   AS codigo_municipio,
    COUNT(*)                                 AS obitos_infantis
  FROM triggo_db.landing.int_obito
  WHERE TRY_TO_NUMBER(idade_anos) IS NOT NULL AND TRY_TO_NUMBER(idade_anos) < 1
  GROUP BY 1,2
)
SELECT
  COALESCE(b.mes, d.mes)                AS mes,
  COALESCE(b.codigo_municipio, d.codigo_municipio) AS codigo_municipio,
  COALESCE(b.nascidos_vivos, 0)         AS nascidos_vivos,
  COALESCE(d.obitos_infantis, 0)        AS obitos_infantis,
  CASE WHEN COALESCE(b.nascidos_vivos,0) > 0
    THEN COALESCE(d.obitos_infantis,0) / COALESCE(b.nascidos_vivos,0)
  END                                   AS taxa_mortalidade_infantil
FROM births b
FULL OUTER JOIN infant_deaths d
  ON b.mes = d.mes
 AND b.codigo_municipio = d.codigo_municipio