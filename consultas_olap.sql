----Consultas no data warehouse------------------
--Média de receita gerada por plataforma de jogo entre 1985 e 2000
SELECT ga.plataforma,a.ano_release,ROUND(AVG(vj.vendas_milhoes),2) AS media_receita
FROM game as ga,vendas_jogos as vj,ano_lancamento as a
WHERE ga.cod_jogo = vj.cod_jogo AND
      a.ano_release = vj.ano_release AND
      a.ano_release BETWEEN 1985 AND 2000
GROUP BY a.ano_release,ga.plataforma
ORDER BY a.ano_release,ga.plataforma

--Média de receita gerada por genero de jogo em cada plataforma entre 1985 e 2000: Drill down da consulta anterior
SELECT ga.plataforma,ga.genero,a.ano_release,ROUND(AVG(vj.vendas_milhoes),2) AS media_receita
FROM game as ga,vendas_jogos as vj,ano_lancamento as a
WHERE ga.cod_jogo = vj.cod_jogo AND
      a.ano_release = vj.ano_release AND
      a.ano_release BETWEEN 1985 AND 2000
GROUP BY ga.plataforma,ga.genero,a.ano_release
ORDER BY ga.plataforma,ga.genero,a.ano_release

--Soma da receita gerada por todos os jogos lançados em 2006 No Japão
SELECT v.pais,v.continente,a.ano_release,ROUND(SUM(vj.vendas_milhoes),2) AS soma_receita
FROM vendas as v,ano_lancamento as a,vendas_jogos as vj
WHERE a.ano_release = vj.ano_release AND
      v.cod_venda = vj.cod_venda AND
      a.ano_release = 2006 AND
      v.pais = 'Japao'
GROUP BY v.pais,v.continente,a.ano_release

--Soma da receita gerada por todos os jogos lançados em 2006 na ásia: Roll-up da consulta anterior
SELECT v.continente,a.ano_release,ROUND(SUM(vj.vendas_milhoes),2) AS soma_receita
FROM vendas as v,ano_lancamento as a,vendas_jogos as vj
WHERE a.ano_release = vj.ano_release AND
      v.cod_venda = vj.cod_venda AND
      a.ano_release = 2006 AND
      v.continente = 'Asia'
GROUP BY v.continente,a.ano_release

--Receita máxima dos jogos entre 2000 e 2006
SELECT ga.jogo, a.ano_release,MAX(vj.vendas_milhoes) AS max_receita
FROM game as ga,ano_lancamento as a,vendas_jogos as vj
WHERE ga.cod_jogo = vj.cod_jogo AND
      a.ano_release = vj.ano_release AND
      a.ano_release BETWEEN 2000 AND 2006
GROUP BY a.ano_release,ga.jogo
Order BY a.ano_release

--Receita máxima dos jogos do genero RPG entre 2000 e 2006 (SLICE da consulta anterior))
SELECT ga.jogo, a.ano_release,MAX(vj.vendas_milhoes) AS max_receita
FROM game as ga,ano_lancamento as a,vendas_jogos as vj
WHERE ga.cod_jogo = vj.cod_jogo AND
      a.ano_release = vj.ano_release AND
      a.ano_release BETWEEN 2000 AND 2006 AND
      ga.genero = 'Role-Playing'
GROUP BY a.ano_release,ga.jogo
Order BY a.ano_release