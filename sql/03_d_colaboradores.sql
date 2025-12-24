CREATE OR REPLACE TABLE d_colaborador AS
SELECT
    k.cod_colaborador AS colaborador_id,
    k.primeiro_nome || ' ' || ultimo_nome AS nome_completo,
    k.email,
    k.idade,
    k.cpf,
    a.cod_agencia AS agencia_id
FROM stg_colaboradores k, stg_colaborador_agencia a
WHERE k.cod_colaborador = a.cod_colaborador;

ALTER TABLE d_colaborador ALTER colaborador_id SET NOT NULL;
ALTER TABLE d_colaborador ADD PRIMARY KEY (colaborador_id);