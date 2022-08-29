---------Criação de usuários---------------------
CREATE USER gerente_vendas WITH PASSWORD 'senha123';
GRANT SELECT ON ALL TABLES IN SCHEMA public TO gerente_vendas;
GRANT UPDATE ON ALL TABLES IN SCHEMA public TO gerente_vendas; --O gerente tem pleno acesso ao dados

CREATE USER analista_vendas WITH PASSWORD 'senha123';
GRANT SELECT ON ALL TABLES IN SCHEMA public TO analista_vendas; --O analista pode ver todas as tabelas para produzir insights

CREATE USER assessor_imprensa WITH PASSWORD 'senha123';
GRANT SELECT ON visao_imprensa TO assessor_imprensa; -- O assessor pode ver os jogos,
-- seu ano de lançamento e o quanto eles venderam

---VISÃO PARA O ASSESSOR DE IMPRENSA
CREATE TABLE visao_imprensa AS(
    SELECT ga.jogo,ga.genero,ga.plataforma,a.ano_release,ROUND(SUM(vendas_milhoes),2)
    FROM game as ga,ano_lancamento as a,vendas_jogos as vj
    WHERE ga.cod_jogo = vj.cod_jogo AND
          a.ano_release = vj.ano_release
    GROUP BY ga.jogo,ga.genero,ga.plataforma,a.ano_release
    ORDER BY plataforma
);
