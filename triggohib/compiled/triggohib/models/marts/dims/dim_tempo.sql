

WITH datas AS (
  SELECT data_nascimento AS data_evento FROM triggo_db.landing.int_nascimento
  UNION
  SELECT data_obito      AS data_evento FROM triggo_db.landing.int_obito
)
SELECT
  data_evento,
  EXTRACT(YEAR  FROM data_evento) AS ano,
  EXTRACT(MONTH FROM data_evento) AS mes,
  EXTRACT(DAY   FROM data_evento) AS dia,
  TO_CHAR(data_evento, 'YYYYMM')  AS ano_mes,
  TO_CHAR(data_evento, 'DY')      AS dia_semana
FROM (SELECT DISTINCT data_evento FROM datas)
WHERE data_evento IS NOT NULL