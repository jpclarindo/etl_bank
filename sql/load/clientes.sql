CREATE OR REPLACE TABLE d_cliente AS
SELECT cod_cliente as cliente_id,
	primeiro_nome, ultimo_nome, email, tipo_cliente, idade, cpfcnpj as cpf_cnpj, 
	cidade as nome_cidade, estado as sigla_estado
FROM stg_clientes;

ALTER TABLE dim_cliente ALTER cliente_id SET NOT NULL;
ALTER TABLE dim_cliente ADD PRIMARY KEY (cliente_id);