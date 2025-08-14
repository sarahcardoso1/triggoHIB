

WITH codigos AS (
  SELECT codigo_municipio_residencia AS codigo_municipio
  FROM triggo_db.landing.int_nascimento
  UNION
  SELECT codigo_mun_residencial AS codigo_municipio
  FROM triggo_db.landing.int_obito
)
SELECT
  codigo_municipio,
  SUBSTR(codigo_municipio,1,2) AS codigo_uf 
FROM (SELECT DISTINCT codigo_municipio FROM codigos)
WHERE codigo_municipio IS NOT NULL