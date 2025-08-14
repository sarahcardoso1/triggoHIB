
  create or replace   view triggo_db.landing.int_nascimento
  
   as (
    

SELECT
  origem_dado,
  codigo_estabelecimento,
  codigo_municipio_nascimento,
  local_nascimento,
  TRY_TO_NUMBER(idade_mae)              AS idade_mae,
  estado_civil_mae,
  escolaridade_mae,
  codigo_ocupacao_mae,
  TRY_TO_NUMBER(qtd_filhos_vivos)      AS qtd_filhos_vivos,
  TRY_TO_NUMBER(qtd_filhos_mortos)     AS qtd_filhos_mortos,
  codigo_municipio_residencia,
  tipo_gestacao,
  tipo_gravidez,
  tipo_parto,
  TRY_TO_NUMBER(qtd_consultas_prenatal) AS qtd_consultas_prenatal,

  CASE
    WHEN data_nascimento IS NOT NULL AND LENGTH(TRIM(data_nascimento)) = 8
      THEN TO_DATE(data_nascimento, 'DDMMYYYY')
    ELSE TRY_TO_DATE(data_nascimento)
  END AS data_nascimento,

  hora_nascimento,
  sexo_recem_nascido,
  TRY_TO_NUMBER(apgar_primeiro_minuto) AS apgar_primeiro_minuto,
  TRY_TO_NUMBER(apgar_quinto_minuto)   AS apgar_quinto_minuto,
  raca_cor_recem_nascido,
  TRY_TO_NUMBER(peso_ao_nascer_gramas) AS peso_ao_nascer_gramas,
  indicador_anomalia,
  data_cadastro,
  codigo_anomalia,
  numero_lote,
  versao_sistema,
  data_recebimento,
  diferenca_datas,
  data_registro_origem,
  naturalidade_mae,
  codigo_municipio_naturalidade_mae,
  codigo_uf_naturalidade_mae,
  escolaridade_mae_2010,
  serie_escolar_mae,
  data_nascimento_mae,
  raca_cor_mae,
  TRY_TO_NUMBER(qtd_gestacoes_mae)     AS qtd_gestacoes_mae,
  TRY_TO_NUMBER(qtd_partos_normais_mae) AS qtd_partos_normais_mae,
  TRY_TO_NUMBER(qtd_partos_cesarea_mae) AS qtd_partos_cesarea_mae,
  TRY_TO_NUMBER(idade_pai)             AS idade_pai,
  data_ultima_menstruacao,
  semanas_gestacao,
  tipo_estimativa_gestacao,
  consultas_prenatal,
  mes_inicio_prenatal,
  tipo_apresentacao_feto,
  trabalho_parto_induzido,
  cesarea_parto_indicada,
  tipo_assistencia_nascimento,
  tipo_funcao_responsavel,
  tipo_documento_responsavel,
  data_declaracao,
  escolaridade_mae_agrupada,
  indicador_epidemiologico,
  indicador_nova_declaracao,
  codigo_pais_residencia,
  tipo_obito_recente,
  paridade_mae,
  indice_kotelchuck,
  contador_registro
FROM triggo_db.landing.stg_sinasc
  );

