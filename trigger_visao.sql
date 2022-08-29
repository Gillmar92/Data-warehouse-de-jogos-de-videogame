-------TRIGGER para a inclusão de novos jogos--------------
CREATE OR REPLACE FUNCTION insere_jogo()
RETURNS TRIGGER AS $novo_jogo$
BEGIN
    INSERT INTO venda_jogo_00_06 (SELECT ga.jogo,a.ano_release,new.vendas_milhoes FROM game as ga,ano_lancamento as a, vendas_jogos as vj
                                   WHERE ga.cod_jogo = new.cod_jogo AND
                                          a.ano_release = new.ano_release AND
                                          a.ano_release BETWEEN 2000 AND 2006
                                    group by ga.jogo,a.ano_release);
RETURN NEW;
END;
$novo_jogo$ LANGUAGE plpgsql;

CREATE TRIGGER novo_jogo AFTER INSERT ON vendas_jogos
FOR EACH ROW EXECUTE PROCEDURE insere_jogo();

--INSERÇÕES PARA TESTE DO TRIGGER
INSERT INTO game VALUES (4111,'Kingdom Hearts II','Role-Playing','PS2');
INSERT INTO game VALUES (1111,'Kingdom hearts', 'Role-Playing','PS2');
INSERT INTO vendas VALUES (401,'Japao','Asia');
INSERT INTO vendas VALUES (402,'Japao','Asia');
INSERT INTO vendas_jogos VALUES (401,4111,2006,59.1);
INSERT INTO vendas_jogos VALUES (402,1111,2002,60.5);
                             
                             