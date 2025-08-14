# triggoHIB


## 📊 Data Insights Brazil 
#### Projeto de Modelagem e Análise de Dados do DataSUS
### 📌 Descrição Geral

Este projeto tem como objetivo demonstrar o processo completo de ingestão, transformação e análise de dados de nascimento e óbito, providenciados pelo DataSUS  , _utilizando Databricks, Snowflake e dbt_.
A solução final permite consultas e análises que podem gerar insights relevantes sobre saúde pública no Brasil.

---
### 🛠️ Arquitetura da Solução
A arquitetura foi projetada para garantir eficiência, escalabilidade e transparência no fluxo de dados:

#### Databricks:
- Conexão aos servidores FTP do DataSUS para download dos arquivos .dbc.
- Conversão para .csv utilizando bibliotecas especializadas.
- Envio dos dados diretamente para o Snowflake.

#### Snowflake:
- Armazenamento dos dados brutos e tabelas intermediárias.
- Integração direta com o dbt para a camada de transformação.
- Orquestração da pipeline.

#### dbt (Data Build Tool):
- Criação de modelos de staging, intermediate e marts (dimensão e fato).
- Documentação e testes de integridade.
- Geração de documentação navegável via dbt docs.

---
| Ferramenta   | Função |
|--------------|--------|
| Databricks   | Ingestão e conversão dos dados do FTP |
| Snowflake    | Armazenamento e integração com o dbt |
| dbt          | Transformação, documentação e testes |

--- 
### 💡 Inovações Implementadas
- Pipeline híbrido Databricks + Snowflake + dbt.
- Conversão automatizada de arquivos .dbc direto para o ambiente analítico.
- Estrutura de documentação e testes integrada ao dbt.

### 🎯 Decisões de Design
- Uso do Databricks para ingestão: escolhido por sua escalabilidade e integração com Snowflake.
- Armazenamento no Snowflake: garante performance e facilidade de integração com ferramentas analíticas.
- Modelagem no dbt: separação clara entre camadas staging e marts, com documentação e testes incorporados.
- Conversão .dbc → .csv no Databricks: evita pré-processamento manual e agiliza a carga.
---
### 🤖 Orquestração e automação 
#### O fluxo é dividido em duas principais etapas de automação:

- Ingestão e pré-processamento → realizada no *Databricks Jobs*
- Transformação e disponibilização → realizada no *Snowflake Tasks*

#### 🐝1. Ingestão no Databricks
- *Objetivo:* Captar os arquivos brutos do FTP do DataSUS, processar os arquivos .dbc para .csv e salvar diretamente no Snowflake Stage.
- *Ferramenta:* Databricks Jobs
- *Justificativa:* Simulação de uma arquitetura híbrida; o Databricks oferece um ambiente escalável para processar grandes volumes de dados.
-- Permite criar Jobs agendados que podem executar notebooks automaticamente (ex.: diariamente ou mensalmente, conforme atualização dos dados no FTP).
---
#### Fluxo de Ingestão
- 📒 Notebook Databricks -->
- 🔌 Conexão com o FTP do DataSUS -->
- 📥 Download e leitura dos arquivos .dbc -->
- 🔄 Conversão para .csv -->
- ❄️ Escrita no Stage (Landing) do Snowflake via Snowflake Connector

#### Job Databricks:
-🔌 Executa o notebook automaticamente em horários pré-definidos.

---
#### ❄️ 2. Transformação no Snowflake
- *Objetivo:* Executar os modelos dbt para padronizar, limpar e estruturar os dados para análise.
- *Ferramenta:* Snowflake Tasks
- *Justificativa:* Snowflake Tasks permite agendar e encadear queries diretamente no ambiente de banco de dados, sem depender de infraestrutura externa; reduz latência, pois as transformações são feitas no próprio data warehouse.

#### ✨ Fluxo de Transformação
- Task 1 → Carrega dados do stage para tabelas raw
- Task 2 → Executa os modelos dbt no Snowflake (via dbt Cloud API ou Snowflake External Functions)
- Task 3 → Atualiza as tabelas finais (analytics) para consumo
----

### ⚡ Como Rodar o Projeto
#### Pré-requisitos:
📌 1. Conta ativa no Snowflake com credenciais configuradas.
- Databricks Workspace (ou outro ambiente Python) para ingestão.
- Python 3.x, com pacotes: pandas, readdbc, snowflake-connector-python.
- dbt instalado e configurado com o profile do Snowflake.
  
📌 2. Ingestão dos dados (Databricks):
- Rodar o notebook que conecta ao FTP do DataSUS.
- Conversão dos arquivos .dbc para .csv.
- Upload para o stage do Snowflake.

📌 3. Transformação (dbt + Snowflake):
- Instalar dependências do dbt (caso haja): `dbt deps`
- Compilar os modelos: `dbt compile`
- Executar os modelos: `dbt run`
- Gerar e servir a documentação navegável:
`dbt docs generate`
`dbt docs serve`
---- 
### 🔦 Insights 
#### Ao utilizar duas bases de dados possivelmente correlatas, é possível analisar ambas as bases conjuntas e separadamente. 

#### 1️⃣ Taxa de Mortalidade Infantil por Município
- *Descrição:* Calcula a relação entre óbitos infantis (SIM DOINF) e nascimentos vivos (SINASC) em cada município.
  
*Relevância:* Identifica municípios com maior risco de mortalidade infantil, permitindo direcionar políticas públicas e recursos de saúde.

- 👓 *Como gerar:*
- Contar o número de nascimentos por município na tabela SINASC.
- Contar o número de óbitos por município na tabela DOINF.
- Calcular: taxa_mortalidade = (óbitos / nascidos_vivos) * 1000.
Exemplo:
🌟 Municípios com taxa acima da média nacional podem ser priorizados para programas de saúde materno-infantil.

#### 2️⃣ Peso ao Nascer x Mortalidade Neonatal

- *Descrição:* Analisa o risco de óbito neonatal (até 28 dias) em função do peso ao nascer.

*Relevância:* Bebês de baixo peso têm maior risco de mortalidade; identificar padrões ajuda na prevenção e acompanhamento neonatal.
  
- 👓 *Como gerar:*
- Usar coluna PESO da tabela SINASC para categorizar bebês (baixo peso < 2500g, muito baixo < 1500g).
- Cruzar com coluna DTNASC e data_obito da tabela DOINF para filtrar óbitos neonatais.
- Calcular taxa de mortalidade por categoria de peso.
Exemplo:
🌟 Bebês com menos de 1500g apresentam taxa de mortalidade significativamente maior, reforçando a necessidade de _cuidado neonatal intensivo._

#### 3️⃣ Impacto da Assistência Pré-Natal
Descrição:
- Avalia a relação entre número de consultas pré-natais (CONSULTAS na tabela SINASC) e desfechos como prematuridade ou óbito infantil.

*Relevância:*
Identifica se a cobertura e frequência do pré-natal influenciam diretamente nos desfechos de saúde da criança, permitindo intervenções preventivas.

- 👓 *Como gerar:*
- Agrupar nascimentos por número de consultas pré-natais.
- Calcular percentual de bebês prematuros ou óbitos infantis por grupo.

Exemplo:
🌟 Municípios ou grupos com menos de _4 consultas pré-natais apresentam maior incidência de baixo peso ou óbitos, reforçando a importância do acompanhamento pré-natal adequado._

---- 
### 📋 Documentação adicional:
- 🔗 Documentação DBT 
