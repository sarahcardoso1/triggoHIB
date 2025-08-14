{{ config(materialized='table') }}

SELECT DISTINCT
  sexo,
  CASE
    WHEN idade_anos IS NULL THEN 'Desconhecida'
    WHEN idade_anos < 1 THEN '0-1 ano'
    WHEN idade_anos BETWEEN 1 AND 4 THEN '1-4 anos'
    ELSE '5+ anos'
  END AS faixa_etaria
FROM {{ ref('int_obito') }}