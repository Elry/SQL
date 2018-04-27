SELECT CONCAT(UPPER(LEFT(a.primeiro_nome, 1)), RIGHT(LOWER(a.primeiro_nome), LENGTH(a.primeiro_nome)-1))  FROM ator a
