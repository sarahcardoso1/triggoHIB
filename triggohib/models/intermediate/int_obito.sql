{{ config(materialized='view') }}

SELECT
  origem,
  tipo_obito,

  CASE
    WHEN data_obito IS NOT NULL AND LENGTH(TRIM(data_obito)) = 8
      THEN TO_DATE(data_obito, 'DDMMYYYY')
    ELSE TRY_TO_DATE(data_obito)
  END AS data_obito,

  TRY_TO_NUMBER(idade_raw) AS idade_anos,

  sexo,
  codigo_mun_residencial,
  causa_basica
FROM {{ ref('stg_doinf') }}
WHERE NULLIF(TRIM(idade_raw), '') IS NOT NULL
