CREATE OR REPLACE TABLE d_conta AS
SELECT
    num_conta AS conta_id,
    tipo_conta,
    data_abertura,
    saldo_total,
    saldo_disponivel,
    data_ultimo_lancamento,
    -- Chaves Estrangeiras exigidas no diagrama da dimensão
    cod_cliente AS cliente_id,
    cod_agencia AS agencia_id,
    cod_colaborador AS colaborador_id
FROM stg_contas;

ALTER TABLE d_conta ALTER conta_id SET NOT NULL;
ALTER TABLE d_conta ADD PRIMARY KEY (conta_id);