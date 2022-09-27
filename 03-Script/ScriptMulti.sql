
CREATE TABLE public.dim_data (
                sk_data INTEGER NOT NULL,
                nk_data DATE NOT NULL,
                desc_data_completa VARCHAR(60) NOT NULL,
                nr_ano INTEGER NOT NULL,
                nm_trimestre VARCHAR(20) NOT NULL,
                nr_ano_trimestre VARCHAR(20) NOT NULL,
                nr_mes INTEGER NOT NULL,
                nm_mes VARCHAR(20) NOT NULL,
                ano_mes VARCHAR(20) NOT NULL,
                nr_semana INTEGER NOT NULL,
                ano_semana VARCHAR(20) NOT NULL,
                nr_dia INTEGER NOT NULL,
                nr_dia_ano INTEGER NOT NULL,
                nm_dia_semana VARCHAR(20) NOT NULL,
                flag_final_semana CHAR(3) NOT NULL,
                flag_feriado CHAR(3) NOT NULL,
                nm_feriado VARCHAR(60) NOT NULL,
                etl_dt_inicio TIMESTAMP NOT NULL,
                etl_dt_fim TIMESTAMP NOT NULL,
                versao INTEGER NOT NULL,
                CONSTRAINT dim_data_pk PRIMARY KEY (sk_data)
);


CREATE TABLE public.dim_avaliacao (
                sk_cod_avaliacao INTEGER NOT NULL,
                nk_cod_avaliacao INTEGER NOT NULL,
                nota INTEGER NOT NULL,
                etl_dt_inicio TIMESTAMP NOT NULL,
                etl_dt_fim TIMESTAMP NOT NULL,
                versao INTEGER NOT NULL,
                CONSTRAINT sk_cod_avaliacao PRIMARY KEY (sk_cod_avaliacao)
);


CREATE SEQUENCE public.dim_produto_sk_cod_prod_seq;

CREATE TABLE public.dim_produto (
                sk_cod_prod INTEGER NOT NULL DEFAULT nextval('public.dim_produto_sk_cod_prod_seq'),
                nk_cod_prod INTEGER NOT NULL,
                preco REAL NOT NULL,
                tamanho VARCHAR(1) NOT NULL,
                sabor VARCHAR(20) NOT NULL,
                etl_dt_inicio TIMESTAMP NOT NULL,
                etl_dt_fim TIMESTAMP NOT NULL,
                versao INTEGER NOT NULL,
                CONSTRAINT sk_cod_prod PRIMARY KEY (sk_cod_prod)
);


ALTER SEQUENCE public.dim_produto_sk_cod_prod_seq OWNED BY public.dim_produto.sk_cod_prod;

CREATE SEQUENCE public.dim_cliente_sk_codigo_seq;

CREATE TABLE public.dim_cliente (
                sk_codigo INTEGER NOT NULL DEFAULT nextval('public.dim_cliente_sk_codigo_seq'),
                nk_codigo INTEGER NOT NULL,
                idade INTEGER NOT NULL,
                etl_dt_inicio TIMESTAMP NOT NULL,
                etl_dt_fim TIMESTAMP NOT NULL,
                versao INTEGER NOT NULL,
                CONSTRAINT nk_codigo PRIMARY KEY (sk_codigo)
);


ALTER SEQUENCE public.dim_cliente_sk_codigo_seq OWNED BY public.dim_cliente.sk_codigo;

CREATE TABLE public.ft_venda (
                sk_cod_prod INTEGER NOT NULL,
                sk_codigo INTEGER NOT NULL,
                sk_data INTEGER NOT NULL,
                sk_cod_avaliacao INTEGER NOT NULL,
                desconto REAL NOT NULL,
                valor_total REAL NOT NULL
);


ALTER TABLE public.ft_venda ADD CONSTRAINT dim_data_ft_venda_fk
FOREIGN KEY (sk_data)
REFERENCES public.dim_data (sk_data)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_venda ADD CONSTRAINT dim_avaliacao_ft_venda_fk
FOREIGN KEY (sk_cod_avaliacao)
REFERENCES public.dim_avaliacao (sk_cod_avaliacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_venda ADD CONSTRAINT dim_produto_ft_venda_fk
FOREIGN KEY (sk_cod_prod)
REFERENCES public.dim_produto (sk_cod_prod)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_venda ADD CONSTRAINT dim_cliente_ft_venda_fk
FOREIGN KEY (sk_codigo)
REFERENCES public.dim_cliente (sk_codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
