--------VISÕES FRAGMENTADAS------------------------
CREATE TABLE vendas_85_00 AS (
    SELECT ga.plataforma,ga.genero,a.ano_release,vj.vendas_milhoes
    FROM game as ga,ano_lancamento as a,vendas_jogos as vj
    WHERE ga.cod_jogo = vj.cod_jogo AND
          a.ano_release = vj.ano_release AND
          a.ano_release BETWEEN 1985 AND 2000
);

CREATE TABLE vendas_lugar_06 AS (
SELECT v.pais,v.continente,a.ano_release,vj.vendas_milhoes
FROM ano_lancamento as a, vendas as v, vendas_jogos as vj
WHERE a.ano_release = vj.ano_release AND
      v.cod_venda = vj.cod_venda AND
      a.ano_release = 2006
);

CREATE TABLE venda_jogo_00_06 AS (
SELECT ga.jogo,a.ano_release,vj.vendas_milhoes
FROM game as ga,ano_lancamento as a,vendas_jogos as vj
WHERE ga.cod_jogo = vj.cod_jogo AND
      a.ano_release = vj.ano_release AND
      a.ano_release BETWEEN 2000 AND 2006
);