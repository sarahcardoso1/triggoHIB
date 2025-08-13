# triggoHIB


## 📊 Data Insights Brazil 
#### Projeto de Modelagem e Análise de Dados do DataSUS
### 📌 Descrição Geral

Este projeto tem como objetivo demonstrar o processo completo de ingestão, transformação e análise de dados de nascimento e óbito, providenciados pelo DataSUS  , _utilizando Databricks, Snowflake e dbt_.
A solução final permite consultas e análises que podem gerar insights relevantes sobre saúde pública no Brasil.

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

| Ferramenta   | Função |
|--------------|--------|
| Databricks   | Ingestão e conversão dos dados do FTP |
| Snowflake    | Armazenamento e integração com o dbt |
| dbt          | Transformação, documentação e testes |
