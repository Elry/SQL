-- 1.Faça uma consulta que retorne as três primeiras letras dos nomes dos atores.
    SELECT LEFT(a.primeiro_nome, 3) FROM Ator a
    -- 2nd way: --
    SELECT SUBSTR(a.primeiro_nome, 1, 3) FROM Ator a

-- 2.Faça uma consulta que retorne o nome completo em um campo, e as iniciais do nome em outro campo.
    SELECT CONCAT(a.primeiro_nome, ' ', a.ultimo_nome) AS Nome,
        CONCAT(LEFT(a.primeiro_nome, 1), LEFT(a.ultimo_nome, 1)) AS Iniciais
        FROM Ator a
    -- 2nd way: --
    SELECT CONCAT_WS(' ', a.primeiro_nome, a.ultimo_nome) AS Nome,
        CONCAT(LEFT(a.primeiro_nome, 1), LEFT(a.ultimo_nome, 1)) AS Iniciais
        FROM Ator a

-- 3.Monte uma lista de todos os atores classificados de acordo com o maior nome completo (Primeiro nome e último nome).
    SELECT LENGTH(CONCAT(a.primeiro_nome, '', a.ultimo_nome)) AS SizeOfName FROM Ator a
        ORDER BY SizeOfName DESC

-- 4.Monte uma consulta que agrupe e mostre a quantidade de cada grupo de nomes que rimam (Considere nomes que rimam, aqueles que terminam com as mesmas duas letras).
    SELECT CONCAT(a.primeiro_nome, ' ', a.ultimo_nome), CONCAT(b.primeiro_nome, ' ', b.ultimo_nome) AS Rimam FROM Ator a, Ator b 
        WHERE RIGHT(a.ultimo_nome, 2) = RIGHT(b.ultimo_nome, 2) AND a.ator_id < b.ator_id

-- 5.Faça uma consulta que transforme as consoantes em LowerCase e mantenha as vogais em UpperCase:
    SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
            LOWER(CONCAT(a.primeiro_nome, ' ', a.ultimo_nome)), 
            'a', 'A'), 'e', 'E'), 'i', 'I'), 'o', 'O'), 'u', 'U') AS StrangeName
        FROM Ator a

-- 6.Faça uma estimativa de quanto a locadora teria ganho se cada filme custasse valor arredondado, ou seja $3,00 ao invés de $2,99; $5,00 ao invés de $4,99 e assim por diante.
    SELECT SUM(ROUND(f.preco_da_locacao, 1)) FROM filme f

-- 7.Faça uma estimativa de quanto a locadora teria ganho se sempre fosse dado desconto dos valores em centavos (Se um filme custa $3,50 teria $0,50 de desconto, se custa $1,80 teria $0,80 de desconto).
    SELECT SUM(TRUNCATE(f.preco_da_locacao)) FROM filme f
    -- 2nd way: --
    SELECT SUM(f.preco_da_locacao DIV 1) FROM filme f

-- 8.Faça uma lista classificando os filmes pela quantidade de dias que os mesmos ficam nos clientes.
    SELECT f.titulo, SUM(DATEDIFF(a.data_de_devolucao, a.data_de_aluguel)) AS Difference FROM aluguel a
        INNER JOIN inventario i ON a.inventario_id = i.inventario_id
        INNER JOIN filme f ON i.filme_id = f.filme_id
        GROUP BY f.filme_id
        ORDER BY Difference DESC

-- 9.Qual dia da semana têm mais aluguéis de filmes.
    SELECT COUNT(0) AS qtdy, CASE
        WHEN DAYOFWEEK(a.data_de_aluguel) = 1 THEN 'Domingo'
        WHEN DAYOFWEEK(a.data_de_aluguel) = 2 THEN 'Segunda'
        WHEN DAYOFWEEK(a.data_de_aluguel) = 3 THEN 'Terça'
        WHEN DAYOFWEEK(a.data_de_aluguel) = 4 THEN 'Quarta'
        WHEN DAYOFWEEK(a.data_de_aluguel) = 5 THEN 'Quinta'
        WHEN DAYOFWEEK(a.data_de_aluguel) = 6 THEN 'Sexta'        
        ELSE 'Sábado'
        END AS WeekDaya
        FROM Aluguel a
    GROUP BY WeekDaya
    ORDER BY qtdy DESC

-- 10.Faça uma lista dos atores que a segunda letra do nome seja "A".
    SELECT a.primeiro_nome FROM Ator a WHERE INSTR(LEFT(a.primeiro_nome, 2), 'A')
    -- 2nd way: --
    SELECT a.primeiro_nome FROM Ator a WHERE SUBSTR(a.primeiro_nome, 2, 1) = 'A'

-- 11.Faça uma lista dos filmes que contenham no campo recursos especiais "Behind the Scenes"
    SELECT f.titulo, f.recursos_especiais FROM filme f WHERE INSTR(f.recursos_especiais, 'Behind the Scenes') > 0

-- 12.Faça uma lista com a quantidade de filmes de cada categoria, porém o nome da categoria deve estar em Português.
    SELECT f.titulo, COUNT(f.filme_id) AS Quantidade, CASE
        WHEN c.nome = 'Action' THEN 'Ação'
        WHEN c.nome = 'Animation' THEN 'Animação'
        WHEN c.nome = 'Children' THEN 'Infantil'
        WHEN c.nome = 'Classics' THEN 'Clássicos'
        WHEN c.nome = 'Comedy' THEN 'Comédia'
        WHEN c.nome = 'Drama' THEN 'Drama'
        WHEN c.nome = 'Documentary' THEN 'Documentário'
        WHEN c.nome = 'Family' THEN 'Família'
        WHEN c.nome = 'Foreign' THEN 'Estrangeiro'
        WHEN c.nome = 'Games' THEN 'Jogos'
        WHEN c.nome = 'Horror' THEN 'Terror'
        WHEN c.nome = 'Music' THEN 'Música'
        WHEN c.nome = 'New' THEN 'Lançamentos'
        WHEN c.nome = 'Sci-Fi' THEN 'Ficção Científica'
        WHEN c.nome = 'Sports' THEN 'Esportes'
        WHEN c.nome = 'Travel' THEN 'Viagem'
    END AS Categoria
    FROM filme f
        INNER JOIN filme_categoria fc ON f.filme_id = fc.filme_id
        INNER JOIN categoria c ON fc.categoria_id = c.categoria_id
        GROUP BY Categoria
    
    -- 2nd way: --    
    SELECT COUNT(0) AS Quantidade, tc.Categoria FROM t_categoria tc
        INNER JOIN filme_categoria fc ON tc.categoria_id = fc.categoria_id
        GROUP BY Categoria
        ORDER BY Quantidade DESC

-- VIEW
    CREATE OR REPLACE VIEW t_categoria AS SELECT categoria_id ,CASE
        WHEN c.nome = 'Action' THEN 'Ação'
        WHEN c.nome = 'Animation' THEN 'Animação'
        WHEN c.nome = 'Children' THEN 'Infantil'
        WHEN c.nome = 'Classics' THEN 'Clássicos'
        WHEN c.nome = 'Comedy' THEN 'Comédia'
        WHEN c.nome = 'Drama' THEN 'Drama'
        WHEN c.nome = 'Documentary' THEN 'Documentário'
        WHEN c.nome = 'Family' THEN 'Família'
        WHEN c.nome = 'Foreign' THEN 'Estrangeiro'
        WHEN c.nome = 'Games' THEN 'Jogos'
        WHEN c.nome = 'Horror' THEN 'Terror'
        WHEN c.nome = 'Music' THEN 'Música'
        WHEN c.nome = 'New' THEN 'Lançamentos'
        WHEN c.nome = 'Sci-Fi' THEN 'Ficção Científica'
        WHEN c.nome = 'Sports' THEN 'Esportes'
        WHEN c.nome = 'Travel' THEN 'Viagem'
    END AS Categoria
    FROM Categoria c