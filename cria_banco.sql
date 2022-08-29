-- Criação do Banco de Dados foi feita com o seguinte comando:
-- CREATE database vendas_games

-- Criação das tabelas presentes no Banco de Dados

CREATE TABLE vendas (
	cod_venda INT NOT NULL,
    pais VARCHAR(6),
	continente VARCHAR(25),
	CONSTRAINT venda_pk PRIMARY KEY (cod_venda),
	CONSTRAINT continente_check CHECK (continente in ('America do Norte','Europa','Asia','Outro'))
);

CREATE TABLE game(
    cod_jogo INT NOT NULL,
	jogo VARCHAR(50),
	genero VARCHAR(15),
	plataforma VARCHAR(20),
	CONSTRAINT jogo_pk PRIMARY KEY (cod_jogo)
);

CREATE TABLE ano_lancamento(
	ano_release INT NOT NULL,
	CONSTRAINT ano_pk PRIMARY KEY (ano_release)
);

CREATE TABLE vendas_jogos(
	cod_venda INT NOT NULL,
    cod_jogo INT NOT NULL,
	ano_release INT NOT NULL,
    vendas_milhoes NUMERIC,
    CONSTRAINT vendas_jogos_pk PRIMARY KEY (cod_venda,cod_jogo,ano_release)
);


/* Definição das chaves estrangeiras */
ALTER TABLE vendas_jogos ADD CONSTRAINT cod_venda_fk FOREIGN KEY (cod_venda)
    REFERENCES vendas(cod_venda) ON DELETE CASCADE;
    
ALTER TABLE vendas_jogos ADD CONSTRAINT jogo_fk FOREIGN KEY (cod_jogo)
    REFERENCES game(cod_jogo) ON DELETE CASCADE;
   
ALTER TABLE vendas_jogos ADD CONSTRAINT ano_fk FOREIGN KEY (ano_release)
    REFERENCES ano_lancamento(ano_release) ON DELETE CASCADE;
	