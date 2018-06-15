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