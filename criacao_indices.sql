--------------CRIAÇÃO DOS ÍNDICES---------------
CREATE EXTENSION btree_gin;
CREATE EXTENSION pg_trgm;

-----Índice para a visão fragmentada do grupo de consultas I
CREATE INDEX idxplataforma ON vendas_85_00 using gin(plataforma);
CREATE INDEX idxgenero ON vendas_85_00 using gin(genero);
CREATE INDEX idxano ON vendas_85_00(ano_release);

---Indice para visão fragmentada do grupo de consultas II
CREATE INDEX idxpais ON vendas_lugar_06 using gin(pais);
CREATE INDEX idxcontinente ON vendas_lugar_06 using gin(continente);

----Indice para visão fragmentada do grupo de consultas III
CREATE INDEX idxjogoTrgm ON venda_jogo_00_06 using gin(jogo gin_trgm_ops);
CREATE INDEX idxgenerogame ON venda_jogo_00_06 using gin(genero);