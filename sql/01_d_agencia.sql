CREATE OR REPLACE TABLE d_agencia AS
SELECT
    cod_agencia AS agencia_id,
    nome AS nome_agencia,
    tipo_agencia,
    data_abertura,
    cidade AS nome_cidade, 
    uf AS sigla_estado     
FROM stg_agencias;

ALTER TABLE d_agencia ALTER agencia_id SET NOT NULL;
ALTER TABLE d_agencia ADD PRIMARY KEY (agencia_id);