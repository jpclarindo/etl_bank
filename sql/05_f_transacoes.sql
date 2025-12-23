CREATE OR REPLACE TABLE f_transacao AS
SELECT
    t.num_conta AS conta_id,
    date_diff('day', DATE '1950-01-01', CAST(t.data_transacao AS DATE)) + 1 AS data_id,
    (EXTRACT(HOUR FROM t.data_transacao) * 3600) + 
    (EXTRACT(MINUTE FROM t.data_transacao) * 60) + 
    (EXTRACT(SECOND FROM t.data_transacao)::INTEGER) + 1 AS tempo_id,
    t.nome_transacao AS tipo_transacao,
    t.cod_transacao,
    t.valor_transacao
FROM stg_transacoes t;

ALTER TABLE f_transacao ALTER conta_id SET NOT NULL;
ALTER TABLE f_transacao ALTER data_id SET NOT NULL;
ALTER TABLE f_transacao ALTER tempo_id SET NOT NULL;
ALTER TABLE f_transacao ADD PRIMARY KEY (conta_id, data_id, tempo_id);