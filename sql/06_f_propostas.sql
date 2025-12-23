CREATE OR REPLACE TABLE f_proposta AS
SELECT
    p.cod_proposta,
    p.cod_cliente AS cliente_id,
    p.cod_colaborador AS colaborador_id,
    date_diff('day', DATE '1950-01-01', CAST(p.data_entrada_proposta AS DATE)) + 1 AS data_id,
    (EXTRACT(HOUR FROM data_entrada_proposta) * 3600) + 
    (EXTRACT(MINUTE FROM p.data_entrada_proposta) * 60) + 
    (EXTRACT(SECOND FROM p.data_entrada_proposta)::INTEGER) + 1 AS tempo_id,
    p.taxa_juros_mensal,
    p.valor_proposta,
    p.valor_financiamento,
    p.valor_entrada,
    valor_prestacao,
    p.quantidade_parcelas AS qtde_parcelas,
    p.carencia,
    p.status_proposta AS status    
FROM stg_propostas_credito p;

ALTER TABLE f_proposta ALTER cliente_id SET NOT NULL;
ALTER TABLE f_proposta ALTER colaborador_id SET NOT NULL;
ALTER TABLE f_proposta ALTER data_id SET NOT NULL;
ALTER TABLE f_proposta ALTER tempo_id SET NOT NULL;
ALTER TABLE f_proposta ADD PRIMARY KEY (cliente_id, colaborador_id, data_id, tempo_id);